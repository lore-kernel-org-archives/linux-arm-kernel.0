From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 21:37:23 +0800
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <1363007760.3137.69.camel@x61.thuisdomein>
References: <1363007760.3137.69.camel@x61.thuisdomein>
Message-ID: <20130311133720.GB25910@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Mon, Mar 11, 2013 at 02:16:00PM +0100, Paul Bolle wrote:
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Tested by grepping the tree.
> 
> 1) Typo was added in commit f8c95fe6d9adad72fc7bce90f4ab68d119f50c5b
> ("ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs").
> Looking at that patch and at the tree makes clear that DEBUG_IMX53_UART
> was intended here.

Thanks for the fixing.  Above comment should really be in the commit
log.  I just applied the patch as below.

Shawn

commit 0c52db7e681678f9b2a3fb96c3dd557168b4e025
Author: Paul Bolle <pebolle@tiscali.nl>
Date:   Mon Mar 11 14:16:00 2013 +0100

ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"

Commit f8c95fe (ARM: imx: support DEBUG_LL uart port selection for all
i.MX SoCs) had a typo that DEBUG_IMX50_IMX53_UART should be
DEBUG_IMX53_UART.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
