From: huanglin821201@gmail.com (hl)
Date: Fri, 5 Aug 2016 16:50:49 +0800
Subject: [PATCH v4 1/7] clk: rockchip: add clock flag parameter when
 register pll
In-Reply-To: <4870605.nd4Eof6Gm1@phil>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
 <1469779021-10426-2-git-send-email-hl@rock-chips.com>
 <4870605.nd4Eof6Gm1@phil>
Message-ID: <57A45369.7020804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016?08?05? 06:37, Heiko Stuebner wrote:
> Am Freitag, 29. Juli 2016, 15:56:55 schrieb Lin Huang:
>> From: Heiko St?bner <heiko@sntech.de>
>>
>> add clock flag parameter so we can pass specific clock flag
>> (like CLK_GET_RATE_NOCACHE etc..)to pll driver.
>>
>> Signed-off-by: Heiko St?bner <heiko@sntech.de>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
> applied to my clock branch for 4.9 after some minor edits on the commit
> message.
  I can not found your clock branch for 4.9, can you share me the patch 
ID, i want
cherry-pick it to my downstream branch.
>
> Thanks
> Heiko
>
>
