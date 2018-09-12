RSpec.describe MediaInfo::Tracks do

  describe '*? for each types instance methods' do

    context 'when the chosen parser (MEDIAINFO_XML_PARSER) is the default one' do
      include_context 'sets MEDIAINFO_XML_PARSER to default value'

      it_behaves_like 'for a valid collection of file path of videos' do
        let(:videos) { videos_xml_files_content }
      end

      it_behaves_like 'for a valid collection of file path of images' do
        let(:images) { images_xml_files_content }
      end

      context 'when the specified type is included in these Tracks' do
        it 'returns true' do
          expect(MediaInfo.from(xml_files_content[:sample_iphone_mov]).other?).to eq(true)
          expect(MediaInfo.from(xml_files_content[:multiple_streams_with_id]).video2?).to eq(true)
        end
      end

      context 'when the specified type is not included in these Tracks' do
        it 'returns false' do
          expect(MediaInfo.from(http_valid_video_url).image?).to be_falsey
        end
      end
    end


    context 'when the chosen parser (MEDIAINFO_XML_PARSER) is nokogiri' do
      include_context 'sets MEDIAINFO_XML_PARSER to nokogiri'

      it_behaves_like 'for a valid collection of file path of videos' do
        let(:videos) { videos_xml_files_content }
      end

      it_behaves_like 'for a valid collection of file path of images' do
        let(:images) { images_xml_files_content }
      end

      context 'when the specified type is included in these Tracks' do
        it 'returns true' do
          expect(MediaInfo.from(xml_files_content[:sample_iphone_mov]).other?).to eq(true)
        end
      end

      context 'when the specified type is not included in these Tracks' do
        it 'returns false' do
          expect(MediaInfo.from(xml_files_content[:multiple_streams_with_id]).video5?).to be_falsey
        end
      end
    end

  end

  describe '.count for each types instance method' do

    context 'when the chosen parser (MEDIAINFO_XML_PARSER) is the default one' do
      include_context 'sets MEDIAINFO_XML_PARSER to default value'

      context 'when the specified type is included in these Tracks' do
        it 'returns the number of occurrences of this type' do
          expect(MediaInfo.from(xml_files_content[:subtitle]).text.count).to eq(4)
          expect(MediaInfo.from(xml_files_content[:sample_iphone_mov]).audio.count).to eq(1)
          expect(MediaInfo.from(xml_files_content[:multiple_streams_no_id]).video.count).to eq(3)
          expect(MediaInfo.from(http_valid_video_url).video.count).to eq(1)
        end
      end
    end


    context 'when the chosen parser (MEDIAINFO_XML_PARSER) is nokogiri' do
      include_context 'sets MEDIAINFO_XML_PARSER to nokogiri'

      context 'when the specified type is included in these Tracks' do
        it 'returns the number of occurrences of this type' do
          expect(MediaInfo.from(xml_files_content[:subtitle]).text3.count).to eq(1)
          expect(MediaInfo.from(xml_files_content[:multiple_streams_no_id]).video6.count).to eq(1)
          expect(MediaInfo.from(http_valid_video_url).video.count).to eq(1)
        end
      end
    end

  end

  describe '.extra method for \'general\' type' do

    context 'when the chosen parser (MEDIAINFO_XML_PARSER) is the default one' do
      include_context 'sets MEDIAINFO_XML_PARSER to default value'

      context 'when the submitted file has been generated by an Apple device' do
        it 'does not return nil' do
          expect(MediaInfo.from(xml_files_content[:sample_iphone_mov]).general.extra).to_not be(nil)
        end

        it 'returns the correct value for each extra information' do
          expect(MediaInfo.from(xml_files_content[:sample_iphone_mov]).general.extra.com_apple_quicktime_make).to eq('Apple')
        end
      end
    end


    context 'when the chosen parser (MEDIAINFO_XML_PARSER) is nokogiri' do
      include_context 'sets MEDIAINFO_XML_PARSER to nokogiri'

      context 'when the submitted file has been generated by an Apple device' do
        it 'does not return nil' do
          expect(MediaInfo.from(xml_files_content[:sample_iphone_mov]).general.extra).to_not be(nil)
        end

        it 'returns the correct value for each extra information' do
          expect(MediaInfo.from(xml_files_content[:sample_iphone_mov]).general.extra.com_apple_quicktime_software).to eq('11.2.6')
        end
      end
    end

  end

end