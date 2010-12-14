From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 14 Dec 2010 19:00:23 +0200
Subject: [PATCH] MTD: NAND: ams-delta: convert to platform driver
In-Reply-To: <201012111840.05270.jkrzyszt@tis.icnet.pl>
References: <201012111840.05270.jkrzyszt@tis.icnet.pl>
Message-ID: <1292346023.2538.103.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-12-11 at 18:40 +0100, Janusz Krzysztofik wrote:
> In its current form, the driver may break unrelated machines if built into the 
> kernel, hence is not suitable for inclusion into a kernel built for multiple 
> OMAP1 machines. Convert it to a platform driver, that should be free from that 
> issue.
> 
> While being at it, get rid of depreciated omap_read/write(), use ioremap() 
> instead.
> 
> Created and tested against linux-2.6.37-rc5 on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Sorry, but would it please be possible to split this few small patches -
this one is too difficult to review, at least for me.

Thanks!

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
