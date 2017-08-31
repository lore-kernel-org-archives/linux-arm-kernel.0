From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Aug 2017 16:53:57 +0200
Subject: [PATCH v2] arm64: allwinner: a64: add SPI nodes
In-Reply-To: <20170830230637.13010-1-stefan.bruens@rwth-aachen.de>
References: <20170830230637.13010-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170831145357.eyezfjgzvic6e6vq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4803;0c
On Thu, Aug 31, 2017 at 01:06:37AM +0200, Stefan Br?ns wrote:
> The A64 SPI controllers are register compatible to the h3/h5 SPI
> controllers.
> 
> The A64 has two SPI controllers, each with a single chip select.
> The handles for the DMA channels (23/24 for SPI0/SPI1) are omitted,
> as the A64 DMA support is currently missing.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>

Queued for 4.15, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/16625da3/attachment.sig>
