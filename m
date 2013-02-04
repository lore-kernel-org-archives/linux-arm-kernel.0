From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 4 Feb 2013 16:33:16 -0300
Subject: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
 370/XP
In-Reply-To: <20130204190326.GA20212@lunn.ch>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130204165119.GA2440@localhost> <20130204190326.GA20212@lunn.ch>
Message-ID: <20130204193315.GB2456@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Mon, Feb 04, 2013 at 08:03:26PM +0100, Andrew Lunn wrote:
> On Mon, Feb 04, 2013 at 01:51:20PM -0300, Ezequiel Garcia wrote:
> > Hi,
> > 
> > This patchset adds support for the SPI controller
> > available in Armada 370 and Armada XP SoC.
> 
> Hi Ezequiel
> 
> Do any of the boards we have with mainline support have any devices on
> the SPI busses? Its hard to test otherwise.
> 

Mmm... very true.

Recently added Armada XP GP board as an SPI flash.
Probably other evaluation boards also has similar SPI flashes,
but I should check that.

I'll prepare a patch for GP board tomorrow,
based on Gregory's patches for that board,
so you can test that.
Also, I hope to prepare patches for the other
evaluation boards soon.

Regards,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
