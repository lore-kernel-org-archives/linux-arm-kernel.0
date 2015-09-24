From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 25 Sep 2015 01:36:50 +0200
Subject: [PATCH 0/6] mvebu PCI fixes and cleanups
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
Message-ID: <20150924233650.GA24416@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 06:17:07PM +0100, Russell King - ARM Linux wrote:
> This small series contains a number of fixes and cleanups to the
> mvebu PCI host code.

Hi Russell

I've tested this on my Kirkwood based DIR665, which has a Marvell
TopDog wifi card on PCIe. I can join my wifi network, so no obvious
regression.

Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew
