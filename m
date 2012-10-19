From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 19 Oct 2012 02:30:43 +0100
Subject: [PATCH v2 2/2] mfd: Kconfig: Let MFD_SYSCON select REGMAP
In-Reply-To: <1350605046-21358-2-git-send-email-festevam@gmail.com>
References: <1350605046-21358-1-git-send-email-festevam@gmail.com>
 <1350605046-21358-2-git-send-email-festevam@gmail.com>
Message-ID: <20121019013043.GB2353@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 09:04:06PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Building multi_v7_defconfig for mx6 causes the following build error:

> Fix it by selecting REGMAP option.

No, this is silly - selecting MMIO ought to do the right thing.  There's
a patch queued for Linus which will resolve this.
