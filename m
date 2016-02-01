From: caesar.upstream@gmail.com (Caesar Wang)
Date: Mon, 1 Feb 2016 14:40:57 +0800
Subject: [PATCH v4 1/9] ARM: dts: rockchip: add the leds control for kylin
 board
In-Reply-To: <2785565.JmZWWova7F@phil>
References: <1453970618-4383-1-git-send-email-wxt@rock-chips.com>
 <1453970618-4383-2-git-send-email-wxt@rock-chips.com>
 <2785565.JmZWWova7F@phil>
Message-ID: <56AEFDF9.2030905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016?01?31? 18:46, Heiko Stuebner ??:
> Am Donnerstag, 28. Januar 2016, 16:43:30 schrieb Caesar Wang:
>> As the kylin schematic drawing, add the needed work led for
>> kylin board.
>>
>> Run:
>> echo 0 > /sys/class/leds/kylin:red:led/brightness
>> echo 1 > /sys/class/leds/kylin:red:led/brightness
>>
>> The led can normal on/off on kylin board.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> applied to my dts32-branch for 4.6

Okay, thanks.
I'm assuming this patch is applied to your local branch since I have not 
yet see on your branch[0].:-)

branch[0]: 
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v4.6-armsoc/dts32



>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
