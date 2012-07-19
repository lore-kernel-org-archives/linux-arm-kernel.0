From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 19 Jul 2012 10:02:08 +0800
Subject: [PATCH v2 2/2] ARM: dts: imx6q-sabrelite: add usbmisc device
In-Reply-To: <20120718150036.GD30219@S2100-06.ap.freescale.net>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
 <1342607348-8587-3-git-send-email-richard.zhao@freescale.com>
 <20120718150036.GD30219@S2100-06.ap.freescale.net>
Message-ID: <20120719020207.GN21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 11:00:38PM +0800, Shawn Guo wrote:
> On Wed, Jul 18, 2012 at 06:29:07PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
> >  arch/arm/boot/dts/imx6q.dtsi          |   19 +++++++++++++++----
> >  arch/arm/mach-imx/clk-imx6q.c         |    1 +
> 
> It seems that the patch is meant to have dts changes only by reading
> the subject.  So it might be good to get clk-imx6q.c out of here.
Thanks. It'll be divided into two.

Richard
> 
> Shawn
