From: mbizon@freebox.fr (Maxime Bizon)
Date: Mon, 30 Sep 2013 22:21:23 +0200
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <20130924121939.GD12758@n2100.arm.linux.org.uk>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com> <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
Message-ID: <1380572483.31472.51.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2013-09-24 at 13:19 +0100, Russell King - ARM Linux wrote:

Hi Russell,
> 
> Having kbuild wrap the zImage + DTB up into a uImage goes directly
> against this goal, because it turns the produced kernel into something
> which is specific to a single target.  It's much worse than what we
> had before we went to DT, because with this it can only be used on a
> _single_ target, whereas prior to DT we could boot a single kernel
> on a variety of compatible targets.

What would you think of a patch allowing multiple DTB selected using
ATAG number ?

I don't believe telling people to upgrade bootloaders in the field is a
reasonable thing to ask.

We can make fun of vendors for leaving devices with outdated kernel
versions, but this is making life harder for the one who played by the
rules.

-- 
Maxime
