class AvailableSection < ActiveRecord::Base
  has_one :booked_section


  # 執行時間移動 預設是after 也就是當時間大於不再整點的時候把時間往下一半點鐘移動
  # 但在結束時間可以使用before指令把時間往前挪動
  def self.time_shif_to_half_an_hour(chosetime, action='after')
    chosetime = chosetime.to_time
    if chosetime == chosetime.at_beginning_of_hour
      # 檢查是不是跟這個小時的初始時間一樣 一樣的話什麼事情都不用做

    elsif chosetime <= chosetime.at_beginning_of_hour + 30.minute
      # 檢查是不是介於0~30分 如果是的話把時間移到30分
      if action =='after'
        chosetime = chosetime.at_beginning_of_hour + 30.minute
      elsif action =='before'
        chosetime = chosetime.at_beginning_of_hour - 30.minute
      end
    else
      # 剩下的時間都是大於30分 把時間移到下一個整點
      if action =='after'
        chosetime = chosetime.at_beginning_of_hour + 1.hour
      elsif action =='before'
        chosetime = chosetime.at_beginning_of_hour + 30.minute
      end
      chosetime
    end
  end
end
