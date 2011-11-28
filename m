From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 28 Nov 2011 22:03:40 +0800
Subject: [PATCH 3/5] regulator: pass device_node to
 of_get_regulator_init_data()
In-Reply-To: <20111128133425.GE8275@opensource.wolfsonmicro.com>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
 <1322487439-27254-4-git-send-email-shawn.guo@linaro.org>
 <20111128133425.GE8275@opensource.wolfsonmicro.com>
Message-ID: <20111128140339.GA19754@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 01:34:26PM +0000, Mark Brown wrote:
> On Mon, Nov 28, 2011 at 09:37:17PM +0800, Shawn Guo wrote:
> 
> > ---
> >  drivers/regulator/of_regulator.c       |    7 ++++---
> >  include/linux/regulator/of_regulator.h |    6 ++++--
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> Clearly this is going to break the build as you've not updated the
> users.

Sorry, I missed that regulator/fixed.c is already using the api.
Will fix it in v2.

-- 
Regards,
Shawn
