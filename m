From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 15 Dec 2010 11:37:45 +0200
Subject: [PATCH v2] MTD: NAND: ams-delta: convert to platform driver
In-Reply-To: <201012142109.42784.jkrzyszt@tis.icnet.pl>
References: <201012111840.05270.jkrzyszt@tis.icnet.pl>
	<1292346023.2538.103.camel@localhost>
	<201012142109.42784.jkrzyszt@tis.icnet.pl>
Message-ID: <1292405865.2512.28.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-12-14 at 21:09 +0100, Janusz Krzysztofik wrote:
> In its current form, the driver may interfere with different hardware on 
> different boards if built into the kernel, hence is not suitable for 
> inclusion into a defconfig, inteded to be usable with multiple OMAP1 cpu and 
> machine types.
> 
> Convert it to a platform driver, that should be free from this issue.
> 
> Created and tested against linux-2.6.37-rc5 on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
