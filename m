From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 18 May 2015 22:30:19 +0200
Subject: ARMADAXP MV78260 CPU-1:failed to come online
In-Reply-To: <20150518202033.GH21807@lunn.ch>
References: <CAG1O52XwiW9a0+XS==vNAiKoYiVg7TR5XfYrQxHO7R089RWcfg@mail.gmail.com>
 <20150518202033.GH21807@lunn.ch>
Message-ID: <20150518223019.70ccf639@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 18 May 2015 22:20:33 +0200, Andrew Lunn wrote:

> On Tue, May 19, 2015 at 01:17:26AM +0530, raghu MG wrote:
> > Hi,
> > This mail is regarding Linux smp boot on ARMADA-XP MV2860
> > .
> > 
> > CPU-1 doesnt boot/go through the boot sequence & it fails to come
> > online & dumps this message
> > 
> > CPU1:failed to come online .
> > 
> > The CPU-1 boot register is programmed with physical address of
> > -->armada_xp_secondary_startup function & then cpu-0 deasserts the CPU-1.
> > 
> > I am using armada-xp-gp.dts ,I included armada-xp-mv78260.dts in it.
> 
> Does this ring any bells? I have vague recollections of a u-boot
> issue?

On Armada 375/38x yes. On Armada XP, I don't remember.

Raghu, can you make a more specific bug report, that includes:

 * The kernel version you tested
 * The U-Boot version you're using
 * The kernel configuration you're using
 * The complete boot log

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
