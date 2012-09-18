From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 16:13:02 +0800
Subject: [PATCH 33/34] ARM: imx: remove header file mach/irqs.h
In-Reply-To: <201209171132.52380.arnd@arndb.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
 <201209171132.52380.arnd@arndb.de>
Message-ID: <20120918081300.GC6377@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 11:32:52AM +0000, Arnd Bergmann wrote:
> We already have some fiq specific stuff in the
> include/linux/platform_data/asoc-imx-ssi.h header file,
> so I think it's best to put this declaration there, too.
> 
That's indeed a better place.  Thanks for the idea, Arnd.

Shawn
