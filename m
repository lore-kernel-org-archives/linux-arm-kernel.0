From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 23 Jul 2013 12:36:47 -0300
Subject: [PATCH v8 00/28] MBus DT binding for Armada 370/XP and Kirkwood
In-Reply-To: <20130723152406.GH6846@lunn.ch>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130723152406.GH6846@lunn.ch>
Message-ID: <20130723153645.GA5296@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 05:24:06PM +0200, Andrew Lunn wrote:
> On Tue, Jul 23, 2013 at 10:31:04AM -0300, Ezequiel Garcia wrote:
> > After Andrew Lunn reported [1] this work need to take account of Kirkwood
> > to prevent breaking PCIe on such platform, here's a new version adding
> > MBus DT binding for Kirkwood and in particular using it to declare PCIe
> > properly.
> 
> Hi Ezequiel
> 
> I boot tested on my Kirkwood QNAP. Both DT and legacy style. Both boot
> O.K. My device does not actually have any PCI devices on the bus, so
> it is not too good a test. But at least the regression is gone.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> 

Good!

Huge thanks for the test!

Jason: How about picking this up? As I already said, I think it's better
to have this merged sooner than later, and get people to start using it.

I'm ready to fix at once whatever issues might appear.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
