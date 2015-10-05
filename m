From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Oct 2015 00:03:26 +0200
Subject: [PATCH v2 1/2] irqchip: sunxi-nmi: Use driver name instead of DT
 node name for identification
In-Reply-To: <1444063334-19832-2-git-send-email-wens@csie.org>
References: <1444063334-19832-1-git-send-email-wens@csie.org>
 <1444063334-19832-2-git-send-email-wens@csie.org>
Message-ID: <20151005220326.GP2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 12:42:13AM +0800, Chen-Yu Tsai wrote:
> The device tree node name is typically "interrupt-controller", which is
> rather useless when used in printk messages and irq chip names for
> identification purposes. Use the driver name "sunxi-nmi" instead.
> 
> While at it move the identifier from pr_err() calls to the pr_fmt macro.
> 
> Also remove the "__func__" identifier from the error message in the
> interrupt type setting callback, sunxi_sc_nmi_set_type(). The driver
> name in the pr_fmt macro should be enough.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/8c271434/attachment.sig>
