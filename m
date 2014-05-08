From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 22:11:49 -0500
Subject: [PATCH v2 5/7] clk: sunxi: add PRCM (Power/Reset/Clock
 Management) clks support
In-Reply-To: <1399483554-8824-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140508031149.GN7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 07:25:52PM +0200, Boris BREZILLON wrote:
> The PRCM (Power/Reset/Clock Management) unit provides several clock
> devices:
> - AR100 clk: used to clock the Power Management co-processor
> - AHB0 clk: used to clock the AHB0 bus
> - APB0 clk and gates: used to clk peripherals connected to the APB0 bus
> 
> Add support for these clks in a separate driver so that they can be probed
> as platform devices instead of registered during early init.
> This is needed to be able to probe PRCM MFD subdevices.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/db18718e/attachment.sig>
