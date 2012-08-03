From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Aug 2012 14:23:09 +0000
Subject: arm: mvebu: Add basic address decoding support for Marvell 370/XP
In-Reply-To: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201208031423.10561.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 August 2012, Thomas Petazzoni wrote:
> Here is a small patch set that introduces basic support for address
> decoding on Armada 370 and Armada XP. The aim of this basic support is
> essentially to be able to configure a window to remap the BootROM,
> which is needed to startup the secondary CPUs for the SMP support.
> 
> As we had discussed already, the address decoding configuration is not
> described in the Device Tree, it is for now hardcoded on a per-SoC
> basis. We might later discuss how to extend this to the Device Tree.

Makes sense. I wonder if there is a proper way to describe the
setting in the device tree anyway, given that there is more than one
valid option to do it.


	Arnd
