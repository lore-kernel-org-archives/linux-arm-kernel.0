From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 11:34:01 +0200
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
In-Reply-To: <4484941.ZWPK5p5yoC@wuerfel>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <8332148.Z1shujgC24@wuerfel>
 <20140516095953.19522ebd@free-electrons.com>
 <4484941.ZWPK5p5yoC@wuerfel>
Message-ID: <20140519113401.4c83e663@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 19 May 2014 11:12:05 +0200, Arnd Bergmann wrote:

> > The work on Orion5x is still on-going. I'd like to progressively
> > continue the DT migration of Orion5x, moving to multiplatform, and then
> > once it's done, move into mach-mvebu. I'd appreciate to not rush things
> > more than necessary.
> 
> Yes, that's fine. I'd just want to be sure we all understand what is
> going into 3.16 and what isn't.
> 
> So your plan for now is to do DT support in 3.16 and multiplatform after
> 3.16? That won't have any conflicts with the kirkwood patches then, as
> far as I can tell.

Yes, my plan is to have what's already in the 'mvebu' branches for
3.16, i.e the migration to DT of a small number of Orion5x machines, as
well as the corresponding dependencies (pinctrl support, clock support,
etc.).

Then, for 3.17, I'll try to:

 * convert more Orion5x boards to DT
 * support PCIe through DT
 * move to multiplatform

Of course, that's a purely tentative schedule, Orion5x is really a
spare time effort today.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
