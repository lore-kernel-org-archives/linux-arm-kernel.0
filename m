From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 8 Jun 2013 09:26:36 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.10, take 2
In-Reply-To: <20130608011913.GA27720@quad.lixom.net>
References: <20130603150953.GA13853@S2101-09.ap.freescale.net>
 <20130608011913.GA27720@quad.lixom.net>
Message-ID: <20130608012632.GA22134@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 06:19:13PM -0700, Olof Johansson wrote:
> > - Two imx6q clock fixes, which correct axi_sels and ldb_di_sels.
> 
> Are these regressions, or fixes for things that have never worked?

I believe these are errors caught by the drivers that haven't hit
mainline.

Shawn
