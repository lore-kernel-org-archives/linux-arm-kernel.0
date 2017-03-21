From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Mar 2017 08:38:52 -0700
Subject: N900 failure in next-20170321
In-Reply-To: <20170321135708.GA22358@amd>
References: <20170321135708.GA22358@amd>
Message-ID: <20170321153851.GA10760@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [170321 06:59]:
> Hi!
> 
> Tony asked me to test linux-next from time to time. I did... today I
> moved from next-20170309 to next-20170321. Kernel boots and seems to
> work fine (including audio and X startup), but if I leave it sitting
> for a while RGB LED reverts from "system alive" to charging indication
> that was disabled before and system does not react to any input.
> 
> Any ideas?

Not much there I could see affecting this.. Try reverting commit
179125085bd4 ("ARM: OMAP3: Fix smartreflex platform data regression")?

Maybe smartreflex now attempts to do something but we're missing
or have wrong dts configuration for n900?

Regards,

Tony
