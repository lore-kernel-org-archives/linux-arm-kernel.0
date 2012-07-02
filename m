From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Jul 2012 21:16:16 +0200
Subject: [PATCH 2/9] arm: mach-mvebu: add header
In-Reply-To: <20120702210838.37c78fda@skate>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120702183330.GG1348@lunn.ch> <20120702210838.37c78fda@skate>
Message-ID: <20120702191616.GJ1348@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> OMAP has some logic to handle this kind of problems, see
> plat-omap/include/plat/uncompress.h. We can quite certainly overcome
> this problem somehow.

That file says:

         * Initialize the port based on the machine ID from the bootloader.

Which when using DT we don't have.

As you said, we can overcome this somehow. We just need to be aware
there will be changes here.

It would also be nice if Marvell ASIC engineers didn't randomly move
things around in the address space....

       Andrew
