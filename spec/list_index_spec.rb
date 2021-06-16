require './04-15-21_list_pos'

describe ListIndex do
  calc = ListIndex.new
  it 'should return 3 for 456' do
    expect(calc.find_num('456')).to eq 3 
  end
  it 'should return 79 for 454' do
    expect(calc.find_num('454')).to eq 79 
  end
  it 'should return 98 for 455' do
    expect(calc.find_num('455')).to eq 98
  end
  it 'should return 8 for 910' do
    expect(calc.find_num('910')).to eq 8 
  end
  it 'should return 188 for 9100' do
    expect(calc.find_num('9100')).to eq 188 
  end
  it 'should return 187 for 99100' do
    expect(calc.find_num('99100')).to eq 187 
  end
  it 'should return 190 for 00101' do
    expect(calc.find_num('00101')).to eq 190 
  end
  it 'should return 190 for 001' do
    expect(calc.find_num('00101')).to eq 190 
  end
  it 'should return 190 for 00' do
    expect(calc.find_num('00')).to eq 190 
  end
  it 'should return 0 for 123456789' do
    expect(calc.find_num('123456789')).to eq 0 
  end
  it 'should return 0 for 1234567891' do
    expect(calc.find_num('1234567891')).to eq 0
  end
  it 'should return 1000000071 for 123456798' do
    expect(calc.find_num('123456798')).to eq 1000000071
  end
  it 'should return 9 for 10' do
    expect(calc.find_num('10')).to eq 9
  end
  it 'should return 13034 for 53635' do
    expect(calc.find_num('53635')).to eq 13034
  end
  it 'should return 1091 for 040' do
    expect(calc.find_num('040')).to eq 1091
  end
  it 'should return 11 for 11' do
    expect(calc.find_num('11')).to eq 11
  end
  it 'should return 168 for 99' do
    expect(calc.find_num('99')).to eq 168
  end
  it 'should return 122 for 667' do
    expect(calc.find_num('667')).to eq 122
  end
  it 'should return 15050 for 0404' do
    expect(calc.find_num('0404')).to eq 15050
  end
  it 'should return 9 for 10' do
    expect(calc.find_num('10')).to eq 9
  end
  it 'should return 382689688 for 949225100' do
    expect(calc.find_num('949225100')).to eq 382689688
  end
  it 'should return 24674951477 for 58257860625' do
    expect(calc.find_num('58257860625')).to eq 24674951477
  end
  it 'should return 6957586376885 for 3999589058124' do
    expect(calc.find_num('3999589058124')).to eq 6957586376885
  end
  it 'should return 1686722738828503 for 555899959741198' do
    expect(calc.find_num('555899959741198')).to eq 1686722738828503
  end
  it 'should return 10 for 01' do
    expect(calc.find_num('01')).to eq 10
  end
  it 'should return 170 for 091' do
    expect(calc.find_num('091')).to eq 170
  end
  it 'should return 2927 for 0910' do
    expect(calc.find_num('0910')).to eq 2927
  end
  it 'should return 2617 for 0991' do
    expect(calc.find_num('0991')).to eq 2617
  end
  it 'should return 2617 for 09910' do
    expect(calc.find_num('09910')).to eq 2617
  end
  it 'should return 35286 for 09991' do
    expect(calc.find_num('09991')).to eq 35286
  end
end
