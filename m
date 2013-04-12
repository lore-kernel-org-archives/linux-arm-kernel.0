From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 12 Apr 2013 21:24:16 +0200
Subject: [PATCH] clk: si5351: Add gapless tuning for SI5351 PLL
In-Reply-To: <20130412183809.6507.27844@quantum>
References: <1365495975-792-1-git-send-email-michal.bachraty@streamunlimited.com>
 <20130412183809.6507.27844@quantum>
Message-ID: <51685F60.9010802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2013 08:38 PM, Mike Turquette wrote:
> Quoting Michal Bachraty (2013-04-09 01:26:15)
>> For gapless tuning, there is no need for PLL reset and clkout power-down
>> when tuning output. "silabs,gapless-tuning" parameter enables gapless tuning
>> for specific clock output.
>>
>> Signed-off-by: Michal Bachraty<michal.bachraty@streamunlimited.com>
>
> Hi Michal,
>
> This did not apply cleanly on the latest (v8) si5351 clk driver.  Can
> you refresh it?  I do not plan on taking any more patches for 3.10 after
> 3.9-rc7 drops (likely on Sunday or Monday).  So this patch may need to
> wait until after the merge window.

Mike,

I have integrated the above function into clk-si5351 during development
(see clk-si5351 changelog from v6->v7). I think we can drop this patch,
as Michal added his Tested-by to clk-si5351.

Regards,
   Sebastian
