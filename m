From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 22:14:27 +0000
Subject: [PATCH 1/4] ARM: SAMSUNG: cleanup of rtc register definitions
In-Reply-To: <201201041515.45025.heiko@sntech.de>
References: <201112211014.30695.heiko@sntech.de>
 <201201041512.55126.heiko@sntech.de> <201201041514.57688.heiko@sntech.de>
 <201201041515.45025.heiko@sntech.de>
Message-ID: <20120104221427.GL11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 03:15:44PM +0100, Heiko St?bner wrote:
> regs-rtc.h uses a mixture of tabs and spaces and also (x<<y)
> to format bits. So, before adding new stuff clean up the formatting
> and also add spaces to the bit definitions (i.e. (x << y) )

Ok, so this is just a formatting change - and it should stay that way.

However, there's an opportunity missed here.

Are these register definitions used anywhere else other than in the
drivers/rtc driver?  If not, they should be placed along side that
driver or even inside the driver itself.
