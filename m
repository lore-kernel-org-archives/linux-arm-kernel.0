From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Sep 2017 09:43:55 +0200
Subject: [PATCH 05/10] dmaengine: sun6i: Move number of
 pchans/vchans/request to device struct
In-Reply-To: <20170903224100.17893-6-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
 <20170903224100.17893-6-stefan.bruens@rwth-aachen.de>
Message-ID: <20170904074355.niloziky42aki7bg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 12:40:56AM +0200, Stefan Br?ns wrote:
> Preparatory patch: If the same compatible is used for different SoCs which
> have a common register layout, but different number of channels, the
> channel count can no longer be stored in the config. Store it in the
> device structure instead.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>

As stated already, we already are going to have a different
compatible, and this is not something that will change from one
instance to the other. Having code is therefore:
  A) Making the code more complex
  B) For no particular reason.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/98b6865d/attachment-0001.sig>
