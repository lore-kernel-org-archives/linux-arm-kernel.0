From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Jun 2014 12:34:34 +0200
Subject: [PATCH v2 2/5] pinctrl: sunxi: Add IRQCHIP_SKIP_SET_WAKE flag
 for pinctrl irq chip
In-Reply-To: <1401544899-405-3-git-send-email-hdegoede@redhat.com>
References: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
 <1401544899-405-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140602103434.GD27722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 04:01:36PM +0200, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The sunxi pinctrl irq chip driver does not support wakeup at the
> moment. Adding IRQCHIP_SKIP_SET_WAKE lets the irqs work with drivers
> using wakeup.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/7a94d4d1/attachment.sig>
