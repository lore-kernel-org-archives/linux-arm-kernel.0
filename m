From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:51:26 +0100
Subject: [PATCH v2 13/43] drm/sun4i: backend: Use explicit fourcc helpers
 for packed YUV422 check
In-Reply-To: <20181123092515.2511-14-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-14-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085126.4h46nrvz753zymgj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:45AM +0100, Paul Kocialkowski wrote:
> Checking for the number of planes is not sufficient to en ensure that
> the format is a packed YUV422.
> 
> Use explicit fourcc helpers for the check instead.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/88abd99c/attachment.sig>
