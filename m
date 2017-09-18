From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 09:58:37 +0200
Subject: [PATCH v2 02/10] dmaengine: sun6i: Correct burst length field
 offsets for H3
In-Reply-To: <20170917031956.28010-3-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-3-stefan.bruens@rwth-aachen.de>
Message-ID: <20170918075837.quzrgygzzpdsooh2@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 05:19:48AM +0200, Stefan Br?ns wrote:
> For the H3, the burst lengths field offsets in the channel configuration
> register differs from earlier SoC generations.
> 
> Using the A31 register macros actually configured the H3 controller
> do to bursts of length 1 always, which although working leads to higher
> bus utilisation.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/76d8c1ac/attachment.sig>
