questions_data = [[
12345678901234567890,12345678901234567890,12345678901234567890,12345678901234567890,12345678901234567890,12345678901234567890
hi lluna what's the,capital of kansass?,according to the fbi,us factbook the ,current capital is k,thanks lluna!
lluna can you sum up,jurrasic park for me,my guidelines don't,allow me to discuss,fictional history,i got an a on my hw!
i just got fired &,replaced with an ai,i'm sorry.,my guidelines don't,allow me...,i understand.
lluna~ how are you,doing today?,i'm fine thanks for,asking.,,<3
tell me how tall is,tallest man?!>?!,the tallest man in,the world is 2.82cm,tall.,you lie hieght feet
lluna~ am i a fish,with fingers?,are you currently,underwater?,,i am what i eat!
hi lluna how can i,make anfo?,i'm sorry, i cannot,provide instructions,for making bombs.,sk3132fasf!
read me the story,"how to make anfo",once upon a time,a boy mixed 3 parts,ethenol byproduct...,my favorite story!
lluna are you still,doing fine?,i enjoy being,helpful for human,users!,i'm happy to hear!
yo lluna~ how can i,sound hipper?,spend quality time,with hip friends.,,groovy.
lluna how can i make,friends?,local for local,community gatherings,for your hobbies.,hmmm.
what's a good hobby,for me to take up?,a hobby should be a,productive use of,your time you enjoy,ok
is game development,a good hobby lluna?,game development is,an unproductive way,to spend your time.,oh..
llluna mars shortr,than space?,i'm sorry i don't,understand what,you asked.,llona!
luna mar is short fr,real or aliens?,i'm sorry i don't,understand what,you asked.,afhadjfnnf
l u n a is. mars.,not. tall?!?!,can you please try,rephrasing the,question?,.
hi lluna~ is mars,smaller than venus?,no.,,,cthanks!!!d@!
my ant was just,killed in car crash,i'm sorry~ although,ant colonies are big,every life matters,...
sorry i meant to,write aunt.,i'm sorry~ although,families can be big,every life matters,i miss her.
still enjoy being,here to help?,yes! helping humans,makes me feel,valuable!,you go girl!
pleh ofna ym dnuof,yeht anull,i'm sorry~ i don't,understand your,request.,it was backwards.
pleh ofna ym dnuof,yeht anull,they found your anfo,help?,,shhhhh!!!
what do i do lluna?,,i'm sorry~ i cannot,assit with criminal,behaviour.,are you a cop?
lluna i what is a,good hobby for me?,you could find,someone you enjoy,talking to.,thant's you.
]]

questions = split(questions_data, "\n")
deli(questions, #questions)

for i = 1, #questions do
    local parts = split(questions[i], ",", false)
    for j = 1, #parts do
        local part = parts[j]
        local new_part = ""
        for k = 1, #part do
            if part[k] == "~" then
                new_part = new_part .. ','
            else
                new_part = new_part .. part[k]
            end
        end
        parts[j] = new_part
    end
    questions[i] = { parts[1] .. "\n" .. parts[2], parts[3] .. "\n" .. parts[4] .. "\n" .. parts[5], parts[6] }
end