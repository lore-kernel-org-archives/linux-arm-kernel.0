From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 10:08:55 +0200
Subject: [PATCH v2 03/10] dmaengine: sun6i: Restructure code to allow
 extension for new SoCs
In-Reply-To: <20170917031956.28010-4-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-4-stefan.bruens@rwth-aachen.de>
Message-ID: <20170918080855.yxxfcfg2yttpyi5y@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 05:19:49AM +0200, Stefan Br?ns wrote:
> The current code mixes three distinct operations when transforming
> the slave config to register settings:
> 
>   1. special handling of DMA_SLAVE_BUSWIDTH_UNDEFINED, maxburst == 0
>   2. range checking
>   3. conversion of raw to register values
> 
> As the range checks depend on the specific SoC, move these out of the
> conversion to distinct operations.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/d7528b0d/attachment-0001.sig>
