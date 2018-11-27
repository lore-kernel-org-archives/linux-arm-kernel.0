From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:57:06 +0100
Subject: [PATCH v2 21/43] drm/sun4i: frontend: Add support for the
 BGRX8888 input format
In-Reply-To: <20181123092515.2511-22-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-22-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085706.dspg4fuq4e3yt2eo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:53AM +0100, Paul Kocialkowski wrote:
> This introduces support for the BGRX8888 input format for the frontend,
> with its associated pixel sequence value definition. Other fields are
> already configured correctly as they no longer depend on the format's
> fourcc directly.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/a59694a0/attachment-0001.sig>
