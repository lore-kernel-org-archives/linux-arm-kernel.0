From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Oct 2015 16:27:33 +0200
Subject: [PATCH v2 1/2] pinctrl: sunxi: Fix irq_of_xlate for the r_pio
 pinctrl block
In-Reply-To: <1444981572-17235-2-git-send-email-hdegoede@redhat.com>
References: <1444981572-17235-1-git-send-email-hdegoede@redhat.com>
 <1444981572-17235-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20151016142733.GL2711@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 09:46:11AM +0200, Hans de Goede wrote:
> The r_pio gpio / pin controller has a pin_base of non 0, we need to
> adjust for this before calling sunxi_pinctrl_desc_find_function_by_pin.
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/0609b168/attachment-0001.sig>
