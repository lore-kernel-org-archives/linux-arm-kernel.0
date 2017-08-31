From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Aug 2017 16:52:46 +0200
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
 <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
Message-ID: <20170831145246.p4k3uakbn67na3pv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 01:36:09AM +0200, Stefan Br?ns wrote:
> The A64 SoC has the same dma engine as the H3 (sun8i), with a
> reduced amount of physical channels. Add the proper config data
> and compatible string to support it.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++++
>  drivers/dma/sun6i-dma.c                       | 7 +++++++
>  2 files changed, 11 insertions(+)

With what device did you test this? As far as I know, the SPI driver
doesn't use DMA at all.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/ed943cf9/attachment.sig>
