From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 30 Jan 2013 20:30:54 +0100
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <2206499.VqjeY6AxuS@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013 18:26:14 Gregory CLEMENT wrote:
> This is the new Armada XP evaluation board from Marvell. It comes with
> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
> Gigabit links.
> 
> Support for USB (Host and device), SDIO, PCIe will be added as drivers
> when they become available for Armada XP in mainline.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Tested-by: Florian Fainelli <florian@openwrt.org>

The PHY mapping you have is the right one, besides the minor naming in model 
and header comment, this is good, thanks a lot!
-- 
Florian
