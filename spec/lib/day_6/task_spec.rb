describe Day6::Task do
  subject(:task) { described_class.new(sample) }

  describe '#call1' do
    context 'when sample input' do
      let(:sample) { true }

      it 'works' do
        expect(task.call1).to eq(41)
      end
    end

    context 'when real input' do
      let(:sample) { false }

      it 'works' do
        expect(task.call1).to eq(4711)
      end
    end
  end

  describe '#call2' do
    context 'when sample input' do
      let(:sample) { true }

      it 'works' do
        expect(task.call2).to eq(6)
      end
    end

    context 'when real input' do
      let(:sample) { false }

      it 'works' do
        expect(task.call2).to eq(1562)
      end
    end
  end
end
