From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Jul 2013 09:27:31 +0800
Subject: [PATCH] ARM: dts: imx: Add the missing cpus node
In-Reply-To: <1373203228.792969663@f375.mail.ru>
References: <1373202750-10298-1-git-send-email-festevam@gmail.com>
 <1373203228.792969663@f375.mail.ru>
Message-ID: <20130708012729.GA21594@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 07, 2013 at 05:20:28PM +0400, Alexander Shiyan wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > To make it consistent with the other i.mx SoCs, let's add the cpus nodes.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx25.dtsi | 10 ++++++++++
> >  arch/arm/boot/dts/imx27.dtsi | 10 ++++++++++
> >  arch/arm/boot/dts/imx31.dtsi | 10 ++++++++++
> >  arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
> >  4 files changed, 40 insertions(+)
> 
> i.MX27 have a CPU node already.

Applied with imx27.dtsi changes left out.

Shawn
