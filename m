From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 15:28:43 +0000
Subject: [PATCH 5/9] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <2439386.JhP59gsGzr@wuerfel>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <65456683.XbdNkPUDTs@wuerfel>
 <20150313124748.GI8656@n2100.arm.linux.org.uk>
 <2439386.JhP59gsGzr@wuerfel>
Message-ID: <20150313152843.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:08:31PM +0100, Arnd Bergmann wrote:
> I think the easiest and cleanest way would be to let that case not
> happen. Adding the reset controller core makes the kernel about 2kb
> larger, but in most multiplatform configurations, you get it already.

Well, I personally hate selecting visible Kconfig symbols.  It's
against my religion.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
