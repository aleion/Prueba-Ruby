
option = 0

def create_alm(archivo)
  alumnos = []
  file = File.open('alumnos.csv', 'r')
  line = file.readlines
  file.close
  line.each do |alumno|
    alumno_h = {}
    notas = alumno.split(', ').map(&:chomp)
    alumno_h[:name] = notas[0]
    alumno_h[:notas] = notas[1..5]
    alumnos << alumno_h
    pro = sum_notas(alumno_h[:notas]) / alumno_h[:notas].length
    alumno_h[:prom] = pro.to_f
  end
  alumnos
end

def sum_notas(notas)
  sum = notas.inject(0) do |acum, item|
    if item == 'A'
      acum += 1
    else
      acum += item.to_i
    end
  end
  sum.to_f
end

def create_avg
  alumnos = create_alm('alumnos.csv')
  file = File.open('promedios.csv', 'w')
  alumnos.each do |i|
    file.puts "#{i[:name]}, #{sum_notas(i[:notas]) / i[:notas].size}"
  end
  file.close
end

def show_unattendance
  alumnos = create_alm('alumnos.csv')
  alumnos.each do |i|
    notas = i[:notas]
    cantidad = notas.count('A')
    puts "#{i[:name]} tiene #{cantidad} inasistencia"
  end
end

def comp_avg
  alumnos = create_alm('alumnos.csv')
  puts 'Ingresa promedio minimo para aprobar: '
  a_input = gets.chomp.to_f
  if a_input == 0.0.to_f
    avg_input = 5.to_f
  else
    avg_input = a_input
  end
  alumnos.each do |i|
    if i[:prom] < avg_input
      puts "#{i[:name]} ha reprobado con promedio #{i[:prom]}"
    else
      puts "#{i[:name]} ha aprobado con promedio #{i[:prom]}"
    end
  end
end

while option != 4
  puts 'opcion 1:'
  puts 'opcion 2:'
  puts 'opcion 3:'
  puts 'opcion 4:'
  puts
  puts 'Ingresa tu opcion: '
  option = gets.chomp
  system('clear')

    if option.to_i == 1
      create_avg
    elsif option.to_i == 2
      puts
      show_unattendance
      puts
    elsif option.to_i == 3
      puts
      comp_avg
      puts
    elsif option.to_i == 4
      break
    else
      puts 'Ingresa una opcion valida !'
      puts
    end
end
