From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Sep 2015 10:46:59 +0200
Subject: [PATCH] net: sun4i-emac: Properly free resources on probe
 failure and remove
In-Reply-To: <1443001156-20333-1-git-send-email-hdegoede@redhat.com>
References: <1443001156-20333-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150924084659.GP4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 11:39:16AM +0200, Hans de Goede wrote:
> Fix sun4i-emac not releasing the following resources:
> -iomapped memory not released on probe-failure nor on remove
> -clock not getting disabled on probe-failure nor on remove
> -sram not being released on remove
> 
> And while at it also add error checking to the clk_prepare_enable call
> done on probe.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/33153924/attachment-0001.sig>
