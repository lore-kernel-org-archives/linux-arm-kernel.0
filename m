From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 10:12:07 +0200
Subject: [PATCH v2 05/10] dmaengine: sun6i: Move number of
 pchans/vchans/request to device struct
In-Reply-To: <20170917031956.28010-6-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-6-stefan.bruens@rwth-aachen.de>
Message-ID: <20170918081207.5hagvmrc37cnqgvx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4803;0c
On Sun, Sep 17, 2017 at 05:19:51AM +0200, Stefan Br?ns wrote:
> Preparatory patch: If the same compatible is used for different SoCs which
> have a common register layout, but different number of channels, the
> channel count can no longer be stored in the config. Store it in the
> device structure instead.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/d1fd119e/attachment.sig>
