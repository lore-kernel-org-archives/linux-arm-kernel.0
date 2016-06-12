From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 12 Jun 2016 22:51:58 +0800
Subject: [PATCH 05/11] clk: imx: refine the powerup_set bit of clk-pllv3
In-Reply-To: <20160612132928.GG20243@tiger>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <1465396420-27064-5-git-send-email-aisheng.dong@nxp.com>
 <20160612113627.GC20243@tiger>
 <20160612121303.GE32690@shlinux2> <20160612132928.GG20243@tiger>
Message-ID: <CAA+hA=SG1OViVLeZGVBT=eteWE3t8bUYv=sqotVQkF-apNcDFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 9:29 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Sun, Jun 12, 2016 at 08:13:03PM +0800, Dong Aisheng wrote:
>> I understand your point.
>> How about using power_bit and powerup_set?
>> * @power_bit:   pll power bit offset
>
> I'm fine with the name, but the comment should be fixed, since we are
> actually using it as a bit mask instead of offset.
>

Yes, i can change to:
* @power_bit:   pll power bit mask
* @powerup_set: set power_bit to power up the PLL

Regards
Dong Aisheng

> Shawn
>
>> * @powerup_set: set power_bit to power up the PLL
>
