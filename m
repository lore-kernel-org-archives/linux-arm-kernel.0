From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 16:27:38 +0800
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: don't
 request invalid IRQ
In-Reply-To: <6d1e5cdcbfc48df864ec9e0939645c0e95389d2a.1323163127.git.LW@KARO-electronics.de>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <6d1e5cdcbfc48df864ec9e0939645c0e95389d2a.1323163127.git.LW@KARO-electronics.de>
Message-ID: <20111207082737.GC5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:27:12AM +0100, Lothar Wa?mann wrote:
> prevent calling request_irq() with a known invalid IRQ number and
> preserve the return value of the platform_get_irq() function
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Other than subject,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
