From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Sun, 21 Feb 2010 09:27:13 -0500
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <201002211210.12306.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002211105.30079.anarsoul@gmail.com>
	<20100221094151.GC18298@core.coreip.homeip.net>
	<201002211210.12306.anarsoul@gmail.com>
Message-ID: <2accc2ff1002210627i25a76293x398b2806a6dbb200@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Hmm, does evtest utility report all expected events?
>
> evtest shows that driver starts event flood on first touch, i.e. it doesn't
> stop to emit event when stylus is up.

I remember I got bit by this also when I scheduled more conversions
without a timer; pen-up event would not get noticed. I didn't check
the specs to see if there was a way to configure the HW to do
otherwise.
