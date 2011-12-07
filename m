From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 16:26:44 +0800
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: set con_id
 in clk_get() call to NULL
In-Reply-To: <6c28f25c5c6d2f88d0985ce361c5e16f19db27d0.1323163127.git.LW@KARO-electronics.de>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <6c28f25c5c6d2f88d0985ce361c5e16f19db27d0.1323163127.git.LW@KARO-electronics.de>
Message-ID: <20111207082643.GB5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:27:10AM +0100, Lothar Wa?mann wrote:
> The con_id is actually not needed for clk_get().
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Other than subject,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
