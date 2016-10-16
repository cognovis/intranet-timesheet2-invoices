# /packages/intranet-timesheet2-invoices/www/upload-prices-2.tcl
#
# Copyright (C) 2003 - 2009 ]project-open[
#
# All rights reserved. Please check
# http://www.project-open.com/license/ for details.

ad_page_contract {
    /intranet/companies/download-prices.tcl
    Create a .csv-file with header titles exactly matching
    the data model and download the data from im_timesheet_prices
} {
    company_id:integer
} 

set current_user_id [ad_maybe_redirect_for_registration]

set csv_files [list]

lappend csv_files "uom;company;task_type;material;price;currency"

db_foreach priceline "select * from im_timesheet_prices where company_id = :company_id" {
    set csv_fields [list]
    lappend csv_fields [im_category_from_id -translate_p 0 $uom_id]
    set company_path [db_string company_path "select company_path from im_companies where company_id = :company_id"]
    lappend csv_fields $company_path
    lappend csv_fields [im_category_from_id -translate_p 0 $task_type_id]
    lappend csv_fields [db_string material_name "select material_name from im_materials where material_id = :material_id"]
    lappend csv_fields $price
    lappend csv_fields $currency
    lappend csv_files [join $csv_fields ";"]
}

set csv_files_content [join $csv_files "\n"]

set tmp_filename [ns_tmpnam]

# Save the content to a file.
set file [open $tmp_filename w]
fconfigure $file -encoding "utf-8"
puts $file $csv_files_content
flush $file
close $file

set outputheaders [ns_conn outputheaders]
ns_set cput $outputheaders "Content-Disposition" "attachment; filename=${company_path}_prices.csv"

ns_returnfile 200 "text/csv" $tmp_filename
