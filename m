From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 15:02:03 +0200
Subject: [PATCH RESEND v4 1/8] clk: sunxi: Implement A31 USB clock
In-Reply-To: <1400072167-29631-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1400072167-29631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1400072167-29631-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140514130203.GL29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 02:56:00PM +0200, Maxime Ripard wrote:
> The A31 USB clock slightly differ from its older counterparts, mostly because
> it has a different gate for each PHY, while the older one had a single gate for
> all the phy.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mike Turquette <mturquette@linaro.org>

Sorry for this one... PEBKAC...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/2f836098/attachment.sig>
