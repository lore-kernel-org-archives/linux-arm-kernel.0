From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 09:06:34 -0500
Subject: [PATCH] ARM: mvebu: Enable NAND controller in A370 Reference
 Design board
In-Reply-To: <1386800920-7096-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386800920-7096-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131212140634.GP10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 07:28:39PM -0300, Ezequiel Garcia wrote:
> Marvell's Armada 370 Reference Design has a NAND flash, so enable it in
> the devicetree and add the partitions as prepared in the factory images.
> 
> In order to skip the driver's custom device detection and use only ONFI
> detection, the "marvell,keep-config" parameter is used. This is needed
> because we have no support for setting the timings parameters yet.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-rd.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied to mvebu/dt

thx,

Jason.
