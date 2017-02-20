From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Feb 2017 17:50:49 +0100
Subject: [PATCH] ARM: dts: kirkwood: Fix SATA pinmux-ing for TS419
In-Reply-To: <1487608825.2885.1.camel@decadent.org.uk>
References: <20170218003251.GC4152@decadent.org.uk>
 <20170220135955.63fbcaa3@free-electrons.com>
 <1487608825.2885.1.camel@decadent.org.uk>
Message-ID: <20170220175049.45f319bb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 20 Feb 2017 16:40:25 +0000, Ben Hutchings wrote:

> That is precisely what I intended.  20-23 are used by the second
> Ethernet port.  The old board code doesn't assign 4 or 5 at all.

Then I believe it would be more explicit to have separate pin muxing
configurations for SATA on this board.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
