From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Feb 2014 10:04:24 +0100
Subject: [PATCH 0/7] Add Allwinner A10 SPI Controller Driver
In-Reply-To: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140224090424.GC3468@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 10:35:52PM +0100, Maxime Ripard wrote:
> Hi,
> 
> This patchset brings support for the SPI controller found in the
> Allwinner A10 and derived SoCs.
> 
> Even though the controller supports DMA, the driver only supports PIO
> mode for now. This driver will be used to bring up and test DMA on the
> SoC, so support for the DMA will come eventually.
> 
> It doesn't support transfer larger than the FIFO size (64 bytes) for
> now, It's one of the things that will be fixed whenever we will have
> DMA support.

Applied patches 2-7 to sunxi/dt-for-3.15

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/e722acc5/attachment.sig>
