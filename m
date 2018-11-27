From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:49:39 +0100
Subject: [PATCH v2 10/43] drm/fourcc: Add format helpers for checking YUV
 planes disposition
In-Reply-To: <20181123092515.2511-11-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-11-paul.kocialkowski@bootlin.com>
Message-ID: <20181127084939.wspxbohrfeq45oqk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:42AM +0100, Paul Kocialkowski wrote:
> This introduces new format helpers that use the previously-introduced
> format info helpers for checking YUV planes disposition.
> 
> Only the format fourcc is required by these helpers and the formats are
> iterated from the list.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/3cf63b32/attachment.sig>
