From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 20 Apr 2014 16:04:09 -0400
Subject: [PATCH 0/7] Fixes for Armada 370/XP PCIe
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140420200409.GI28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Fri, Apr 18, 2014 at 02:19:46PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of commits fixes a number of problems in the PCIe support of
> the Armada 370 and Armada XP SoCs, allowing to use PCIe devices that
> were not properly supported until now.
> 
> Due to the interaction of PCIe with other subsystems, the fixes are
> not limited to drivers/pci, but also touch drivers/bus and
> drivers/irqchip.

I've tentatively pulled this series as follows:

  patches 1-3 into mvebu/drivers-irqchip-fixes

  patches 4-7 into mvebu/drivers-mbus_pci-fixes

with the latter depending on the former.  I'm going to hold them in
-next for a bit.  At least until we get an Ack from Bjorn.  Then I'll
send them their appropriate ways.

thx,

Jason.
