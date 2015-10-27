From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 27 Oct 2015 12:11:37 +0100
Subject: [PATCH V2] clockevents/drivers/mtk: Fix spurious interrupt
 leading to crash
In-Reply-To: <55DDCC4B.7010203@linaro.org>
References: <1440426924.17418.11.camel@mtksdaap41>
 <1440453450-21203-1-git-send-email-daniel.lezcano@linaro.org>
 <1440508871.29634.1.camel@mtksdaap41> <55DDCC4B.7010203@linaro.org>
Message-ID: <562F5BE9.30200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 26/08/15 16:25, Daniel Lezcano wrote:
> On 08/25/2015 03:21 PM, Yingjoe Chen wrote:
>> Tested-by: Yingjoe Chen<yingjoe.chen@mediatek.com>
>
> Applied to my tree for 4.4.
>
>    -- Daniel
>

Kevin found a regression in v4.3 which will need this patch to fix it 
[1]. Can you apply it to your clockevents/4.3-fixes branch please.

Thanks,
Matthias

[1] https://lkml.org/lkml/2015/10/26/211
