From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 15:00:15 +0800
Subject: [PATCH] ARM: dts: imx7s: add spba-bus abstraction
In-Reply-To: <20180227163049.18809-1-stefan@agner.ch>
References: <20180227163049.18809-1-stefan@agner.ch>
Message-ID: <20180228070014.GL3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 05:30:49PM +0100, Stefan Agner wrote:
> According to the i.MX 7Solo/Dual Application Processor Reference
> Manual the ECSPI1/2/3, UART1/2/3 and SAI1/2/3 peripherals are
> connected through the SPBA bus. Other similar SoCs such as i.MX 6UL
> add this bus abstraction. This adds the bus also to the i.MX 7
> device tree.
> 
> The i.MX SDMA driver uses this abstraction to configure watermark
> levels slightly differently, so this might change behavior slightly.
> There have no issues been observed before or after the patch.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
