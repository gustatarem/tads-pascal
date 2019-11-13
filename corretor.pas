Program corretor;

var option, answer: char;
		examfile, resultsfile: text;
		answerkey: string[60];
		register: string[64];
		index, counter, score, correct, wrong, blank: integer;
		average: real;
		
Begin

	assign(resultsfile, 'results.txt');
	rewrite(resultsfile);

	repeat
		writeln('Qual prova deseja corrigir? (1 ou 2)');
		readln(option);
		if (not(option = '1') and not(option = '2')) then
			writeln('Erro: opção inválida');
	until ((option = '1') or (option = '2'));
	
	assign(examfile, concat('prova', option, '.txt'));
	reset(examfile);
	
	write(resultsfile, 'Resultados da prova: ');
	write(resultsfile, option);
	writeln(resultsfile);
	writeln(resultsfile);
			 
	writeln('Digite o gabarito da prova ');
	for index := 0 to 59 do
		begin
			repeat
				write('Resposta da quest�o ', index + 1, ': ');
				readln(answer);
				answer := upCase(answer);
				if (answer < 'A') or (answer > 'E') then
					writeln('Erro: opção inválida');
			until ((answer >= 'A') and (answer <= 'E'));
			answerkey[index] := answer;
		end;
		
	while(not eof(examfile)) do
		begin
			counter := counter + 1;
			readln(examfile, register);
				blank := 0;
				correct := 0;
				wrong := 0;
				score := 0;
				for index := 0 to 59 do
					begin
						if(register[index + 5] = answerkey[index]) then
							begin
								correct := correct + 1;
					    end
						else if(register[index + 5] >= 'A') and (register[index + 5] <= 'E') then
							begin
								wrong := wrong + 1;
							end
						else
							begin
								blank := blank + 1;
							end;
					end;
			score := correct * 2;
			average := average + score;
			writeln('Prova do aluno de registro: ', register[1], register[2], register[3], register[4]);
			writeln(correct:2:0, ' questões corretas, ', wrong:2:0, ' questões incorretas e ', blank:2:0, ' questões em branco.');
			writeln('Nota: ', score);
			
			write(resultsfile, concat('Prova do aluno de registro: ', register[1], register[2], register[3], register[4]));
			writeln(resultsfile);
			write(resultsfile, correct:2:0);
			write(resultsfile, ' questões corretas, ');
			write(resultsfile, wrong:2:0);
			write(resultsfile, ' questões incorretas e ');
			write(resultsfile, blank:2:0);
			write(resultsfile, ' questões em branco.');
			writeln(resultsfile);
			write(resultsfile, 'Nota: ');
			write(resultsfile, score);
			writeln(resultsfile);
			writeln(resultsfile);	
			
			if(counter mod 30 = 0) then
				readln();
						
		end;
	
	average := average / counter;
	
	writeln('Total de candidatos: ', counter);
	writeln('Média geral: ', average:3:3);
	
	write(resultsfile, 'Total de candidatos: ');
	write(resultsfile, counter);
	writeln(resultsfile);
	write(resultsfile, 'Média geral: ');
	write(resultsfile, average:3:3); 
		
	close(examfile);
	close(resultsfile);
	
	
									
				
	readln();
  
End.