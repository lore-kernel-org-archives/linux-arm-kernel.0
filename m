From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2016 13:44:09 +0100
Subject: [PATCH 03/18] ARM: mvebu: enable E1000E in mvebu_v7_defconfig
In-Reply-To: <1469105055-25181-4-git-send-email-jaz@semihalf.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-4-git-send-email-jaz@semihalf.com>
Message-ID: <20160721124408.GO1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 02:43:59PM +0200, Grzegorz Jaszczyk wrote:
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>

Why?  It's not like this is an on-soc device, but most likely a PCIe card.
Should we build-in all PCIe drivers?

I think it makes more sense to have this as a module rather than built-in.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
