pdf.header pdf.margin_box.top_left do
if FileTest.exists?("#{RAILS_ROOT}/public/uploads/image/institute_logo.jpg")
logo = "#{RAILS_ROOT}/public/uploads/image/institute_logo.jpg"
else
logo = "#{RAILS_ROOT}/public/images/application/app_fedena_logo.jpg"
end
@institute_name=Configuration.get_config_value('InstitutionName');
@institute_address=Configuration.get_config_value('InstitutionAddress');
pdf.image logo, :position=>:left, :height=>50, :width=>50
pdf.font "Helvetica" do
      info = [[@institute_name],
        [@institute_address]]
pdf.move_up(50)
pdf.fill_color "97080e"
pdf.table info, :width => 400,
                :align => {0 => :center},
                :position => :center,
                :border_color => "FFFFFF"
      pdf.move_down(20)
      pdf.stroke_horizontal_rule
        end
end

pdf.move_down(100)
pdf.text @employee.full_name , :size => 18 ,:at=>[75,620]
pdf.text "Employee Profile" ,:size => 7,:at=>[75,610]
pdf.move_down(20)

data= [ ["Perfil Geral" , ""],
        ["Empregado no.", @employee.employee_number],
        ["DOJ", @employee.joining_date.strftime("%d %b, %Y")],
        ["Departamento", @employee.employee_department.name],
        ["Categoria", @employee.employee_category.name],
        ["Posição", @employee.employee_position.name],
        ["Job title", @employee.job_title],
        ["Coordenador", @reporting_manager],
        ["Gênero", @gender],
        ["Estado", @status],
        ["Qualificação", @employee.qualification],
        ["Experiência Total", @total_years.to_s+"Years "+@total_months.to_s+"Months"],
        ["Informações experiência", @employee.experience_detail] ]

pdf.table data, :width => 500,
                :border_color => "000000",
                :border_width   => 1,
                :position => :center,
                :row_colors => ["FFFFFF","DDDDDD"],
                :column_widths =>{ 0 => 200, 1 => 200},
                :align => { 0 => :left, 1 => :left}


    pdf.start_new_page
    pdf.move_down(100)
    pdf.text @employee.full_name , :size => 18 ,:at=>[75,620]
    pdf.text "Employee Profile(Personal)" ,:size => 7,:at=>[75,610]
    pdf.move_down(20)
data = [["Data de Nascimento", @employee.date_of_birth],
        ["Estado Civil", @employee.marital_status],
        ["No. de filhos", @employee.children_count],
        ["Nome do Pai", @employee.father_name],
        ["Nome da Mãe", @employee.mother_name],
        ["Nome do Cônjuge", @employee.husband_name],
        ["Grupo sanguíneo", @employee.blood_group],
        ["Nacionalidade", @employee.nationality.name]]

pdf.table data, :width => 500,
                :border_color => "000000",
                :border_width   => 1,
                :position => :center,
                :row_colors => ["FFFFFF","DDDDDD"],
                :column_widths =>{ 0 => 200, 1 => 200},
                :align => { 0 => :left, 1 => :left}

    pdf.start_new_page
    pdf.move_down(100)
    pdf.text @employee.full_name , :size => 18 ,:at=>[75,620]
    pdf.text "Employee Profile(Address details)" ,:size => 7,:at=>[75,610]
    pdf.move_down(20)

data = [["Endereço Residencial", @employee.home_address_line1],
        ["",@employee.home_address_line2],
        ["Cidade", @employee.home_city],
        ["Estado", @employee.home_state],
        ["País", @home_country],
        ["CEP", @employee.home_pin_code],
        ["Endereço de Trabalho", @employee.office_address_line1],
        ["",@employee.office_address_line2],
        ["Cidade", @employee.office_city],
        ["Estado", @employee.office_state],
        ["País", @office_country],
        ["CEP", @employee.office_pin_code]]
  pdf.table data, :width => 500,
                :border_color => "000000",
                :border_width   => 1,
                :position => :center,
                :row_colors => ["FFFFFF","DDDDDD"],
                :column_widths =>{ 0 => 200, 1 => 200},
                :align => { 0 => :left, 1 => :left}

pdf.start_new_page
pdf.move_down(100)
pdf.text @employee.full_name , :size => 18 ,:at=>[75,620]
pdf.text "Employee Profile(Contact details)" ,:size => 7,:at=>[75,610]
pdf.move_down(20)
data=[["Telefone do trabalho 1", @employee.office_phone1],
      ["Telefone do trabalho 2", @employee.office_phone2],
      ["Celular", @employee.mobile_phone],
      ["Telefone Residencial", @employee.home_phone],
      ["Email", @employee.email],
      ["Fax", @employee.fax] ]

pdf.table data, :width => 500,
                :border_color => "000000",
                :border_width   => 1,
                :position => :center,
                :row_colors => ["FFFFFF","DDDDDD"],
                :column_widths =>{ 0 => 200, 1 => 200},
                :align => { 0 => :left, 1 => :left}

unless @bank_details.empty?
pdf.start_new_page
pdf.move_down(100)
pdf.text @employee.full_name , :size => 18 ,:at=>[75,620]
pdf.text "Employee Profile(Bank Account Details)" ,:size => 7,:at=>[75,610]
pdf.move_down(20)


bank_data = Array.new{Array.new}
@bank_details.each do |b|
  bank_data.push  [[b.bank_field.name],[ b.bank_info]]
end
pdf.table bank_data,:width => 500,
                    :border_color => "000000",
                    :border_width   => 1,
                    :position => :center,
                    :row_colors => ["FFFFFF","DDDDDD"],
                    :column_widths =>{ 0 => 200, 1 => 200},
                    :align => { 0 => :left, 1 => :left}
end

unless @additional_details.empty?
pdf.start_new_page
pdf.move_down(100)
pdf.text @employee.full_name , :size => 18 ,:at=>[75,620]
pdf.text "Employee Profile(Additional Details)" ,:size => 7,:at=>[75,610]
pdf.move_down(20)


other_data = Array.new{Array.new}
@additional_details.each do |add_det|
  other_data.push  [[add_det.additional_field.name],[ add_det.additional_info]]
end
pdf.table other_data,:width => 500,
                    :border_color => "000000",
                    :border_width   => 1,
                    :position => :center,
                    :row_colors => ["FFFFFF","DDDDDD"],
                    :column_widths =>{ 0 => 200, 1 => 200},
                    :align => { 0 => :left, 1 => :left}
end


pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 25] do
     pdf.font "Helvetica" do
        signature = [[""]]
        pdf.table signature, :width => 500,
                :align => {0 => :right,1 => :right},
                :headers => ["Signature"],
                :header_text_color  => "DDDDDD",
                :border_color => "FFFFFF",
                :position => :center
        pdf.move_down(20)
        pdf.stroke_horizontal_rule
    end
end