From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 May 2014 07:13:08 +0200
Subject: [PATCH 2/3] ARM: i.MX1 clk: Add devicetree support
In-Reply-To: <1399629542-32387-2-git-send-email-shc_work@mail.ru>
References: <1399629542-32387-1-git-send-email-shc_work@mail.ru>
 <1399629542-32387-2-git-send-email-shc_work@mail.ru>
Message-ID: <20140512051308.GZ5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 01:59:01PM +0400, Alexander Shiyan wrote:
> This patch adds devicetree support CCM module for i.MX1 (MC9328MX1) CPUs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/clock/imx1-clock.txt       | 46 ++++++++++++++++++++++
>  arch/arm/mach-imx/clk-imx1.c                       | 10 ++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx1-clock.txt b/Documentation/devicetree/bindings/clock/imx1-clock.txt
> new file mode 100644
> index 0000000..f66fe37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx1-clock.txt

Can we meld this for i.MX1 into this patch?:

commit 490dd8808a8baa093ac3b2bfc2f66f798599bb2c
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Thu Nov 14 11:18:57 2013 +0100

    ARM: imx5: introduce DT includes for clock provider
    
    Use clock defines in order to make devicetrees more
    human readable.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
