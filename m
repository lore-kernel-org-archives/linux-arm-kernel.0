From: aisheng.dong@codeaurora.org (Dong Aisheng)
Date: Thu, 25 Jan 2018 20:34:37 +0800
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <1516876026.6411.23.camel@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
 <20180123103609.GD27764@dragon> <1516713799.25726.21.camel@pengutronix.de>
 <ebc8b28d5c2948131cc187ac8177395c@codeaurora.org>
 <1516876026.6411.23.camel@pengutronix.de>
Message-ID: <e6e2fa31e89872fe89924da17759481e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-25 18:27, Lucas Stach wrote:
> Hi Dong,

<snip>

>> And i see the dtsi file does not include Freescale/NXP copyright,
>> is there a reason?
> 
> The dtsi is quite different from the downstream version. But you are
> right, I looked extensively at the downstream version, so I'll add the
> NXP copyright.
> 

Okay, i see.

> BTW: Could you check internally to see if Freescale/NXP would be okay
> with relicensing the DT bits I pulled from downstream as dual GPL-2.0
> and MIT, to align with other DTs in the kernel?
> 

I thought it should be okay. But i pulled Post Lauren in to give you
a confirmed answer.

Lauren,
Can you help with this question?

>> BTW it's quite strange that my gmail did not receive your MX8MQ patch
>> series except clk part.
>> Lucas, Could you help have me CCed next time?
>> I'd like to help review and test the patch series.
>> 
>> For this time, can you help send them all to me as attachment?
> 
> I'm about to send v2 of the series. I'll CC you on the submission.
> 

Great.

>> (You can also send all IMX related patches to linux-imx at nxp.com 
>> maillist
>> i created recently for tracking all IMX related upstream activities.
>> Most Freescale/NXP driver owners are in this list that could help on
>> the review. Shawn, do you think if i can put it in MAINTAINER file?)
> 
> That's great news that there is now a common address for this. I think
> it would be a good idea to have it added to MAINTAINERS as a reviewer.
> 

Thanks for supporting.

Regards
Dong Aisheng

> Regards,
> Lucas
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
