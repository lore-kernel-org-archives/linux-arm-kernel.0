From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2016 14:46:39 +0000
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <87oaab980n.fsf@free-electrons.com>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <87oaab980n.fsf@free-electrons.com>
Message-ID: <20160318144639.GH19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 03:26:48PM +0100, Gregory CLEMENT wrote:
> For Dove I don't know if there are users for this module, but for Orion
> and Kirkwood as they are used in NAS product, I am pretty sure that
> people use it. I would like to have some feedback about users which have
> switched to the new driver. I think Jason did it on kirkwood.

I've tested it (and sent patches to fix issues found) with Dove.  As it
works on Dove, there's no reason not to have it enabled on Dove.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
