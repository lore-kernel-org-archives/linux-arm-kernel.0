From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Jul 2018 17:09:17 +0200
Subject: [PATCH RESEND v2 1/2] drm/sun4i: sun4i: Register quirks with the
 backend structure
In-Reply-To: <20180719080838.31598-1-paul.kocialkowski@bootlin.com>
References: <20180719080838.31598-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180719150917.mzybrbbosjt2i2hm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 10:08:37AM +0200, Paul Kocialkowski wrote:
> In prevision for introducing a new quirk that will be used at atomic
> plane check time, register the quirks structure with the backend
> structure. This way, it can easily be grabbed where needed.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied both, thanks

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/945d6d33/attachment.sig>
