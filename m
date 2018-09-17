From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Sep 2018 10:57:53 -0700
Subject: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
In-Reply-To: <20180917113559.11101-2-lkundrak@v3.sk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
Message-ID: <20180917175753.GE2471@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 01:35:55PM +0200, Lubomir Rintel wrote:
> This is the SPI controller found on Marvel MMP2 and perhaps more
> platforms.

I'm missing patches 2 and 5 from this series.  What's going on with
them, are there any dependencies?

> Changes since v1:
> - s/ssp at d4035000/spi at d4035000/

As covered in SubmittingPatches please put inter-version changelogs
after the --- so they don't end up in the commits.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180917/1a841def/attachment.sig>
