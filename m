From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 16:49:40 +0200
Subject: [PATCH 05/15] clk: sunxi: add A31 APB0 clk gate defintions
In-Reply-To: <1397051478-4113-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140409144940.GE28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 03:51:08PM +0200, Boris BREZILLON wrote:
> Add APB0 gates support for the A31 SoC.
> This gates are controlled by the PRCM (Power/Reset/Clock Management) block
> and thus will act on a different iomem range.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/65648e2f/attachment.sig>
