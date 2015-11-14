describe Plaid::Institution do
  context 'when a single institution is found' do
    let(:institution) { Plaid.institution('5301a93ac140de84910000e0') }
    it { expect(institution).to be_kind_of(Plaid::Institution) }
  end

  context 'when all institutions are found' do
    let(:institution) { Plaid.institution }
    it { expect(institution).to be_kind_of(Array) }
  end

  context 'when institution is not found' do
    it { expect { Plaid.institution('dumb_bank') }.to raise_error }
  end

  context 'when long tail institutions are found' do
    let(:institution) { Plaid.long_tail_institutions }
    before do
      expect(Plaid::Connection).to receive(:post).with(
        'institutions/longtail', {}) {
        { 'total_count' => 42,
          'results' => Plaid::Connection.get('institutions') }
      }
    end
    it { expect(institution).to be_kind_of(Array) }
  end
end
