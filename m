From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:08:19 +0200
Subject: [PATCH v4 4/4] drm/sun4i: Enable DesignWare HDMI for SUN50I
In-Reply-To: <20180904163609.10171-4-jagan@amarulasolutions.com>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-4-jagan@amarulasolutions.com>
Message-ID: <20180905070819.gisznpkvvuqire7c@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 10:06:09PM +0530, Jagan Teki wrote:
> Allwinner SUN50I are now using DesignWare HDMI so enable
> them as default. This can build DRM_SUN8I_DW_HDMI as module
> since DRM in arm64 has module.
> 
> Making this as defult to SUN8I, may cause an issue while
> loading since arm32 DRM built as static.

Uh? Why? We should fix this instead of working around it.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/21685fce/attachment.sig>
