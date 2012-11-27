From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Nov 2012 17:13:42 -0800
Subject: OMAP build now completely broken in latest arm-soc
In-Reply-To: <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk>
 <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
Message-ID: <20121127011341.GO5279@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [121125 05:59]:
> On Sun, Nov 25, 2012 at 1:37 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > But also, the:
> >
> > arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used
> >
> > warning is still there.
> 
> There's a fix for this in Tony's tree, but he hasn't sent up the pull
> request for it yet.

Sent a pull request for that as "omap late timer clean-up
(and a warning fix) for v3.8 merge window". The fix is there
there as the topmost third patch, but that probably does not
matter in this case as the regression was introduced in the
patches queued.

Let me know if you want it separately though.

Regards,

Tony
