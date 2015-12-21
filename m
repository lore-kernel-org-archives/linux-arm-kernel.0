From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 14:44:14 +0800
Subject: [PATCH 1/3] ARM: dts: imx7d: add arch timer
In-Reply-To: <CAHrpEqTQFkme-BmVOPHbFwguQkpbYboaXymrRMc-6TDjwO8dUg@mail.gmail.com>
References: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
 <024b6540b3ebd5f132d171ba40c6e727@agner.ch>
 <CAHrpEqTQFkme-BmVOPHbFwguQkpbYboaXymrRMc-6TDjwO8dUg@mail.gmail.com>
Message-ID: <20151221064414.GD4703@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 03:23:59PM -0600, Zhi Li wrote:
> On Thu, Dec 17, 2015 at 2:45 PM, Stefan Agner <stefan@agner.ch> wrote:
> > On 2015-12-10 15:12, Frank.Li at freescale.com wrote:
> >> From: Frank Li <Frank.Li@freescale.com>
> >>
> >> add cortex a7 arch timer.
> >> uboot v2016.01-rc2 supported psci basic support.
> >> smp can be supported by psci
> >
> > This sounds a bit overly simplified log message. I am not very into this
> > PSCI topic, is this a prerequisit for the ARM arch timers? Maybe you
> > could elaborate that a bit more.
> 
> No.
> But according to previous discussion. Shawn want us to use psci to enable
> second core.  We need enable arch timer if second core enabled.

I guess you can make the commit log a bit better by commenting
the relationship between the arch timer and secondary core.

Shawn
