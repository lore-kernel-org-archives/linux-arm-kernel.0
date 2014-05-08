From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 22:09:02 -0500
Subject: [PATCH v2 3/7] mfd: add support for sun6i PRCM
 (Power/Reset/Clock Management) unit
In-Reply-To: <1399483554-8824-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140508030902.GM7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 07:25:50PM +0200, Boris BREZILLON wrote:
> The PRCM (Power/Reset/Clock Management) block exposes several subdevices
> in different subsystems (clk, reset ...)
> 
> Add basic support for the PRCM unit with clk (AR100, AHB0, and APB0 clks)
> and reset controller subdevices.
> 
> Other subdevices might be added later (if needed).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/c738b902/attachment.sig>
