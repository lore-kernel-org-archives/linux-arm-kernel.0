From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Jul 2013 17:24:06 +0200
Subject: [PATCH v8 00/28] MBus DT binding for Armada 370/XP and Kirkwood
In-Reply-To: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130723152406.GH6846@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 10:31:04AM -0300, Ezequiel Garcia wrote:
> After Andrew Lunn reported [1] this work need to take account of Kirkwood
> to prevent breaking PCIe on such platform, here's a new version adding
> MBus DT binding for Kirkwood and in particular using it to declare PCIe
> properly.

Hi Ezequiel

I boot tested on my Kirkwood QNAP. Both DT and legacy style. Both boot
O.K. My device does not actually have any PCI devices on the bus, so
it is not too good a test. But at least the regression is gone.

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew
