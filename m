From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Feb 2011 07:35:11 -0800
Subject: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
In-Reply-To: <20110222113222.GE2755@pengutronix.de>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110222113222.GE2755@pengutronix.de>
Message-ID: <AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 22, 2011 at 3:32 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Tue, Feb 22, 2011 at 06:13:26PM +0800, Richard Zhu wrote:
>> Fix the NO INT in the Multi-BLK IO in SD/MMC, and
>> Multi-BLK read in SDIO
>>
>> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
>
> Thanks for respinning \o/ This approach looks better to me, but CCing
> Olof to comment on abstraction issues if he has them. Will do a deeper
> review later this week.


I like it! Definitely the right approach. Pushing quirks down into the
I/O accessors is definitely the only scalable way to handle all the
various buggy controllers out there.

Acked-by: Olof Johansson <olof@lixom.net>
