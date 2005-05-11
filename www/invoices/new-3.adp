<!-- packages/intranet-timesheet2-invoices/www/invoices/new-2.adp -->
<!-- @author Juanjo Ruiz (juanjoruizx@yahoo.es) -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<master src="../../../intranet-core/www/master">
<property name="title">@page_title@</property>
<property name="context">@context_bar@</property>
<property name="main_navbar_label">finance</property>

<%= [im_costs_navbar "none" "/intranet/invoicing/index" "" "" [list]] %>

<form action=new-4 method=POST>
<%= [export_form_vars customer_id provider_id invoice_id cost_status_id return_url] %>

@include_task_html;noquote@

  <!-- Invoice Data and Receipient Tables -->
  <table cellpadding=0 cellspacing=0 bordercolor=#6699CC border=0 width=100%>
    <tr valign=top> 
      <td>

        <table border=0 cellPadding=0 cellspacing=2>


	<!-- Invoice Data -->
        <tr>
	  <td align=middle class=rowtitle colspan=2>
	    #intranet-timesheet2-invoices.Invoice_Data#
	  </td>
	</tr>
        <tr>
          <td class=rowodd>#intranet-timesheet2-invoices.Invoice_nr#:</td>
          <td class=rowodd> 
            <input type=text name=invoice_nr size=15 value='@invoice_nr@'>
          </td>
        </tr>
        <tr> 
          <td class=roweven>#intranet-timesheet2-invoices.Invoice_date#:</td>
          <td class=roweven> 
            <input type=text name=invoice_date size=15 value='@invoice_date@'>
          </td>
        </tr>
        <tr> 
          <td class=rowodd>#intranet-timesheet2-invoices.Type#</td>
          <td class=rowodd>
	    <%= [im_cost_type_select cost_type_id $cost_type_id [im_cost_type_company_doc]] %>
	  </td>
        </tr>

<if @cost_type_id@ eq @cost_type_invoice@>
        <tr> 
          <td class=roweven>#intranet-timesheet2-invoices.Payment_terms#</td>
          <td class=roweven> 
            <input type=text name=payment_days size=5 value='@payment_days@'>
            days date of invoice</td>
        </tr>
        <tr> 
          <td class=rowodd>
	    #intranet-timesheet2-invoices.Payment_Method#
	  </td>
          <td class=rowodd>
	    [im_invoice_payment_method_select payment_method_id $payment_method_id]
	  </td>
        </tr>\n"
</if>

        <tr> 
          <td class=roweven>#intranet-timesheet2-invoices.Invoice_template#:</td>
          <td class=roweven>
	    <%= [im_cost_template_select template_id $template_id] %>
	  </td>
        </tr>
        </table>

      </td>
      <td></td>
      <td align=right>

        <table border=0 cellspacing=2 cellpadding=0 >
        <tr>
	  <td align=center valign=top class=rowtitle colspan=2>
	    #intranet-timesheet2-invoices.Recipient#
	  </td>
	</tr>
        <tr> 
          <td  class=rowodd>#intranet-timesheet2-invoices.Company_name#</td>
          <td  class=rowodd>
            <A href=/intranet/companies/view?company_id=@company_id@>@company_name@</A>
          </td>
        </tr>
        <tr> 
          <td  class=roweven>#intranet-timesheet2-invoices.VAT#</td>
          <td  class=roweven>@vat_number@</td>
        </tr>
        <tr> 
          <td  class=rowodd>#intranet-timesheet2-invoices.Accounting_Contact#</td>
          <td  class=rowodd>
            <A href=/intranet/users/view?user_id=@accounting_contact_id@>@company_contact_name@</A>
          </td>
        </tr>
        <tr> 
          <td  class=roweven>#intranet-timesheet2-invoices.Adress#</td>
          <td  class=roweven>@address_line1@ <br> @address_line2@</td>
        </tr>
        <tr> 
          <td  class=rowodd>#intranet-timesheet2-invoices.Zip#</td>
          <td  class=rowodd>@address_postal_code@</td>
        </tr>
        <tr> 
          <td  class=roweven>#intranet-timesheet2-invoices.Country#</td>
          <td  class=roweven>@country_name@</td>

        </tr>
        <tr> 
          <td  class=rowodd>#intranet-timesheet2-invoices.Phone#</td>
          <td  class=rowodd>@phone@</td>
        </tr>
        <tr> 
          <td  class=roweven>#intranet-timesheet2-invoices.Fax#</td>
          <td  class=roweven>@fax@</td>
        </tr>
        <tr> 
          <td  class=rowodd>#intranet-timesheet2-invoices.Email#</td>
          <td  class=rowodd>@company_contact_email@</td>
        </tr>
        </table>

    </tr>
  </table>

  <!-- the list of tasks (invoicable items) -->
  <table cellpadding=2 cellspacing=2 border=0 width='100%'>
    @task_table;noquote@
  </table>

  <!-- the list of task sums, distinguised by type and UOM -->
  <table width=100%>
    <tr>
      <td align=right><table border=0 cellspacing=2 cellpadding=1>
        @task_sum_html;noquote@


	<!-- grand_total -->
        <tr>
          <td> 
          </td>
          <td colspan=4 align=right> 
            <table border=0 cellspacing=1 cellpadding=0>
              <tr> 
                <td>#intranet-timesheet2-invoices.VAT#</td>
                <td><input type=text name=vat value='@vat@' size=4> % &nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td> 
          </td>
          <td colspan=4 align=right> 
            <table border=0 cellspacing=1 cellpadding=0>
              <tr> 
                <td>#intranet-timesheet2-invoices.TAX#</td>
                <td><input type=text name=tax value='@tax@' size=4> % &nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp; </td>
          <td colspan=6 align=right> 
              <input type=submit name=submit value='@button_text@'>
          </td>
        </tr>




      </td>
    </tr>
  </table>

</form>

<!-- the list of reference prices -->
<table>
  @reference_price_html;noquote@
</table>
