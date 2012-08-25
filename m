From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 25 Aug 2012 17:15:24 +0200
Subject: [3.6-rc3 regression] sata_mv cannot get optional clkdev breaking
 boot on QNAP TS-119P+
In-Reply-To: <20536.52397.140042.917795@pilspetsen.it.uu.se>
References: <20536.52397.140042.917795@pilspetsen.it.uu.se>
Message-ID: <20120825151524.GH9886@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 25, 2012 at 03:01:33PM +0200, Mikael Pettersson wrote:
> My Kirkwood-based QNAP TS-119P+ boots fine with the 3.5 kernel.  With
> 3.6-rc2 and 3.6-rc3 however sata_mv complains:
> 
> sata_mv sata_mv.0: cannot get optional clkdev
> sata_mv sata_mv.0: slots 32 ports 2
> 
> and then the kernel grinds to a halt with no further messages.
> 
> Full boot log from 3.6-rc3 appended below.  .config available upon
> request, but this is a non-DT kernel.

Hi Mikael

This is a known issue. See:

http://comments.gmane.org/gmane.linux.ports.arm.kernel/181989

There are patches being developed to fix this. I hope we can push them
to an RC soon.

   Andrew
