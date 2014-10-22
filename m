From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 18:01:19 +0200
Subject: [PATCH v3 1/4] input: Add new sun4i-lradc-keys driver
In-Reply-To: <1413976265-12805-2-git-send-email-hdegoede@redhat.com>
References: <1413976265-12805-1-git-send-email-hdegoede@redhat.com>
 <1413976265-12805-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20141022160119.GH7893@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Oct 22, 2014 at 01:11:02PM +0200, Hans de Goede wrote:
> Allwinnner sunxi SoCs have a low resolution adc (called lradc) which is
> specifically designed to have various (tablet) keys (ie home, back, search,
> etc). attached to it using a resistor network. This adds a driver for this.
> 
> There are 2 channels, currently this driver only supports chan0 since there
> are no boards known to use chan1.
> 
> This has been tested on an olimex a10s-olinuxino-micro, a13-olinuxino, and
> a20-olinuxino-micro.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141022/7c020a22/attachment.sig>
