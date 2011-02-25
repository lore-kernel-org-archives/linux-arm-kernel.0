From: davidb@codeaurora.org (David Brown)
Date: Thu, 24 Feb 2011 19:20:45 -0800
Subject: [PATCH v2 2/2] msm: add single-wire serial bus interface (SSBI)
	driver
In-Reply-To: <AANLkTikD1Ued=rit1QbMWwe3NGFz2iQ-KO7B=-N6Ok-2@mail.gmail.com>
	(Dima Zavin's message of "Thu, 24 Feb 2011 18:39:48 -0800")
References: <1298585954-22422-1-git-send-email-kheitke@codeaurora.org>
	<1298585954-22422-3-git-send-email-kheitke@codeaurora.org>
	<1298600621.17118.27.camel@m0nster>
	<8yad3mgdeut.fsf@huya.qualcomm.com>
	<1298601346.17118.29.camel@m0nster>
	<AANLkTikD1Ued=rit1QbMWwe3NGFz2iQ-KO7B=-N6Ok-2@mail.gmail.com>
Message-ID: <8ya8vx4dcky.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24 2011, Dima Zavin wrote:

> On that note, should we have a "drivers/arm/msm" instead of just
> "drivers/msm"? Other non-msm arm sub-arches probably have the same
> problem and polluting drivers/ top-level for every arm-subarch maybe
> undesirable.

I'm moving linux-kernel to the 'to' field, and adding Greg KH to CC.

This is about a new driver (ssbi) for the MSM chips, and where the
driver for this should go.  The driver is specific to MSM chips (as far
as I know, the bus is only supported there).  There are likely to be
future msm-specific drivers, so the suggestion was to put this under
drivers/msm, or possibly drivers/arm/msm.

Anyone other suggestions, or preferences for the location?

Thanks,
David Brown
