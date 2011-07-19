From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 19 Jul 2011 20:48:49 +0800
Subject: [alsa-devel] [PATCH v3 00/10] ARM: mxs: add audio support
In-Reply-To: <20110718203816.GA9457@pengutronix.de>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
	<20110718203816.GA9457@pengutronix.de>
Message-ID: <CAA+hA=Td_kQMV==BU=gHYe7jOiLPY_4qMJ4HtA9VOJ5F-Z5fBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/19 Wolfram Sang <w.sang@pengutronix.de>:
> On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:
>
>> This patch series is to add audio support based on saif for mxs platform.
>> The driver only supports playback currently.
>> For capturing, due to hardware limitation that we have to use two saif
>> instances to implement full duplex (playback & recording), we need to
>> figure out a good design to fit in ASoC as the following work.
>
> So, since the codec problems seem to be resolved now (and they were luckily
> really just codec-problems):
>
> For the ASoC-patches (1-4):
>
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
Hi Mark,

For ASoC patches (1-4), do you have any more comments?


> For the mach-mxs-Patches (5-9, 10 is already picked up), assuming patch 6 will
> lose the DIGCTRL-handling:
>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>
> I think this series is good for 3.1. Now we just need the mxs-dma bugfix on
> top, but that's a different patch...
>
> Regards,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
