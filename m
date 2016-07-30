From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Jul 2016 17:14:34 +0200
Subject: [PATCH v2 3/5] mmc: sunxi: Factor out clock phase setting code
 into a helper function
In-Reply-To: <1469888748-26085-4-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20160730151433.GP6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 04:25:46PM +0200, Hans de Goede wrote:
> Add a sunxi_mmc_clk_set_phase() helper function.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/b35d8c39/attachment.sig>
