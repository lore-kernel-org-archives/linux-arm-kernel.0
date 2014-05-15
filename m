From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 May 2014 10:35:20 +0200
Subject: [PATCH v4 0/7] mfd: add basic sun6i A31 PRCM support
In-Reply-To: <1400071101-30553-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1400071101-30553-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140515083520.GN29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 14, 2014 at 02:38:14PM +0200, Boris BREZILLON wrote:
> Hello,
> 
> This patch series adds support for some functions provided by the PRCM
> (Power/Reset/Clock Management) unit:
> - AR100, AHB0 and APB0 clocks
> - APB0 reset controller

Merged patches 1 and 2 with Philipp's Acked-by in
sunxi/drivers-for-3.16, and patch 7 in sunxi/dt-for-3.16.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/19d790ce/attachment.sig>
