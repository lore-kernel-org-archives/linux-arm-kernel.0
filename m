From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 31 May 2011 09:04:59 +0200
Subject: [PATCH] Fix typo in  mm/proc-arm7tdmi.S
In-Reply-To: <w4aae3bv6m.wl%peter@chubb.wattle.id.au>
References: <w4aae3bv6m.wl%peter@chubb.wattle.id.au>
Message-ID: <20110531070459.GT9907@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On Tue, May 31, 2011 at 09:55:13AM +1000, Peter Chubb wrote:
> There's a typo that prevents building for the arm7tdmi: you get an
> error like `unknown size' from the assembler because symbol
> __arm7dmi_proc_info is not defined.
> 
> Signed-off-by: Peter Chubb <peter.chubb@nicta.com.au>
This was already fixed by Ben Hutchings[1] back in March, but didn't
made it in. Ben's patch also fixed the same error in
arch/arm/mm/proc-arm9tdmi.S.

I will forward Ben's patch to Russell's patch system.

Best regards
Uwe

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/109743

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
