From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Aug 2014 08:58:31 +0100
Subject: [PATCHv2] ARM: debug: uncompress debug support for omap2plus
In-Reply-To: <1409038140-7433-1-git-send-email-kpark3469@gmail.com>
References: <1409038140-7433-1-git-send-email-kpark3469@gmail.com>
Message-ID: <20140826075831.GU30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 04:28:59PM +0900, kpark3469 at gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
> 
> Since OMAP low-level debug code places data in the .data section,
> The symbol DEBUG_UNCOMPRESS was defined with !DEBUG_OMAP2PLUS_UART.
> This patch removes the part using data section in debug/omap2plus.S,
> so DEBUG_UNCOMPRESS is now available on OMAP system.
> 
> Signed-off-by: Sahara <keun-o.park@windriver.com>
> Tested-by: Afzal Mohammed <afzal.mohd.ma@gmail.com> (on am335x beagle
> bone white)

You need to consider whom you are sending this to.  It would be well
worth including the OMAP maintainer, Tony Lindgren.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
