From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 25 Feb 2015 15:29:24 +0100
Subject: [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
In-Reply-To: <20150225135015.GA17992@lunn.ch>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
 <20150223143416.GT1509@kw.sim.vm.gnt> <54EB3C84.30503@roeck-us.net>
 <20150225111430.GV1509@kw.sim.vm.gnt>
 <20150225135015.GA17992@lunn.ch>
Message-ID: <20150225142924.GX1509@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 02:50:15PM +0100, Andrew Lunn wrote:
> > Handle the GPIO fan alarm feature from the fan controller driver don't
> > look good either to me. This alarm mechanism is not a part of the fan
> > controller itself but rather something apart. Also I am afraid that the
> > result would really look like a hack.
> 
> Hi Simon
> 
> It sounds like you need to extract the alarm code from gpio-fan into a
> little library. Then put a wrapper around it to make a gpio-fan-alarm
> driver.

Hi Andrew,

Yes, I am working on that. I'll come back with some patches based on
this approach.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/794db90a/attachment.sig>
