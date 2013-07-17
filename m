From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Jul 2013 11:53:23 +0800
Subject: [PATCH] ARM: mxs: pm: Include "pm.h"
In-Reply-To: <1373981559-23743-1-git-send-email-fabio.estevam@freescale.com>
References: <1373981559-23743-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130717035321.GE4541@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 10:32:39AM -0300, Fabio Estevam wrote:
> Fix the following sparse warning:
> 
> arch/arm/mach-mxs/pm.c:37:13: warning: symbol 'mxs_pm_init' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
