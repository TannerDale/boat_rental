require './lib/dock'

RSpec.describe 'Dock' do
  it 'has a name' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock.name).to eq("The Rowing Dock")
  end

  it 'has a max rental time' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock.max_rental_time).to eq(3)
  end

  it 'logs rentals' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    expected = {
      kayak_1 => patrick,
      kayak_2 => patrick,
      sup_1 => eugene
    }
    expect(dock.rental_log).to eq(expected)
  end

  it 'can charge a renter' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    kayak_1.add_hour
    kayak_1.add_hour

    charge = dock.charge(kayak_1)

    expect(charge[:card_number]).to eq(patrick.credit_card_number)
    expect(charge[:amount]).to eq(40)
  end

  it 'doesnt charge for more than 3 hours' do
    dock = Dock.new("The Rowing Dock", 3)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    eugene = Renter.new("Eugene Crabs", "1313131313131313")
    dock.rent(sup_1, eugene)

    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour

    charge = dock.charge(sup_1)
    expect(charge[:amount]).to eq(45)

    sup_1.add_hour

    charge = dock.charge(sup_1)
    expect(charge[:amount]).to eq(45)
  end

  it 'has revenue after boats are returned' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

    dock.log_hour

    dock.rent(canoe, patrick)

    dock.log_hour

    expect(dock.revenue).to eq(0)

    dock.return(kayak_1)
    dock.return(kayak_2)
    dock.return(canoe)

    expect(dock.revenue).to eq(105)

    dock.rent(sup_1, eugene)
    dock.rent(sup_2, eugene)

    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.log_hour

    dock.return(sup_1)
    dock.return(sup_2)

    expect(dock.revenue).to eq(195)
  end
end
