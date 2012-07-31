From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jul 2012 08:27:23 +0800
Subject: [PATCH v2] ARM: mxs: always build ocotp
In-Reply-To: <1343653574-31100-1-git-send-email-mkl@pengutronix.de>
References: <1343653574-31100-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20120731002720.GA762@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 03:06:14PM +0200, Marc Kleine-Budde wrote:
> With this patch ocotp support will always be build into the kernel on mxs.
> Otherwise a DT-only kernel fails to link with:
> 
> arch/arm/mach-mxs/mach-mxs.c:169: undefined reference to `mxs_get_ocotp'
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Queued it up, thanks.

-- 
Regards,
Shawn
