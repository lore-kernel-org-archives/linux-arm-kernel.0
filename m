From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Mar 2016 16:35:18 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318144639.GH19428@n2100.arm.linux.org.uk>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <87oaab980n.fsf@free-electrons.com>
 <20160318144639.GH19428@n2100.arm.linux.org.uk>
Message-ID: <20160318163518.122505a5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Romain,

On Fri, 18 Mar 2016 14:46:39 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 18, 2016 at 03:26:48PM +0100, Gregory CLEMENT wrote:
> > For Dove I don't know if there are users for this module, but for Orion
> > and Kirkwood as they are used in NAS product, I am pretty sure that
> > people use it. I would like to have some feedback about users which have
> > switched to the new driver. I think Jason did it on kirkwood.
> 
> I've tested it (and sent patches to fix issues found) with Dove.  As it
> works on Dove, there's no reason not to have it enabled on Dove.

Great! So it means that it's fine to update mvebu_v7_defconfig,
multi_v7_defconfig and dove_defconfig to use the new driver.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
