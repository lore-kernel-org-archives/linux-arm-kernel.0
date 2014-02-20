From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Feb 2014 09:30:54 +0800
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
In-Reply-To: <20140220114242.b3ce4d77b677544d2feebd3e@canb.auug.org.au>
References: <20140220114242.b3ce4d77b677544d2feebd3e@canb.auug.org.au>
Message-ID: <20140220013051.GK3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 11:42:42AM +1100, Stephen Rothwell wrote:
> Hi Shawn,
> 
> Today's linux-next merge of the imx-mxs tree got conflicts in
> arch/arm/mach-imx/Makefile and arch/arm/mach-imx/common.h between commit
> 28a9f3b078c5 ("ARM: imx6: build pm-imx6q.c independently of CONFIG_PM")
> from the arm-soc tree and commits 8dd751932545 ("ARM: imx: add suspend in
> ocram support for i.mx6q") and 79a8eef47d12 ("RM: imx: add suspend in
> ocram support for i.mx6sl") from the imx-mxs tree.
> 
> I fixed it up (I think, see below) and can carry the fix as necessary (no
> action is required).

Thanks, Stephen.  Once "ARM: imx6: build pm-imx6q.c independently of
CONFIG_PM" hits mainline, I will rebase my branch against the latest -rc
to get rid of the conflicts.

Shawn
