From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:54:52 +0100
Subject: [PATCH v2 18/43] drm/sun4i: frontend: Add proper definitions for
 format registers
In-Reply-To: <20181123092515.2511-19-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-19-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085452.6p25yxzlfrrgrpuw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:50AM +0100, Paul Kocialkowski wrote:
> This introduces proper definitions for the input and output format
> configuration registers instead of a macro and raw values in the code,
> with the intent to increase code readability and reduce indirections.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/4207637f/attachment.sig>
