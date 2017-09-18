From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 10:09:27 +0200
Subject: [PATCH v2 04/10] dmaengine: sun6i: Enable additional burst
 lengths/widths on H3
In-Reply-To: <20170917031956.28010-5-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-5-stefan.bruens@rwth-aachen.de>
Message-ID: <20170918080927.ghfahn2xwz52hmsx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 05:19:50AM +0200, Stefan Br?ns wrote:
> The H3 supports bursts lengths of 1, 4, 8 and 16 transfers, each with
> a width of 1, 2, 4 or 8 bytes.
> 
> The register value for the the width is log2-encoded, change the
> conversion function to provide the correct value for width == 8.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/aa3088bc/attachment.sig>
