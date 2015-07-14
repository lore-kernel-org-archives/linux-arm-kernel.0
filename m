From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jul 2015 21:49:45 -0700
Subject: [PATCH] arm: dts: dra7: arch timer sits in always-on power domain
In-Reply-To: <CAGo_u6oM2rtdvLp3deDsxJJWpJ6YZJ5b02m1qDdxhEjUH_69dg@mail.gmail.com>
References: <1436820101-2172-1-git-send-email-balbi@ti.com>
 <CAGo_u6oM2rtdvLp3deDsxJJWpJ6YZJ5b02m1qDdxhEjUH_69dg@mail.gmail.com>
Message-ID: <20150714044944.GA11198@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150713 13:56]:
> On Mon, Jul 13, 2015 at 3:41 PM, Felipe Balbi <balbi@ti.com> wrote:
> > According to DRA7x TRM section 4.3.5 Realtime Counter (Master Counter),
> > the realtime counter sits in the Wakeup Always-On Power domain.
> > Furthermore, the counter will automatically switch the 32K clock source
> > when MPU goes into standby and automatically switch back to SYS_CLK or
> > ABE_LP when MPU goes out of standby.

That's good to hear. Is that the case also for 5432?

Regards,

Tony
