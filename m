From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 9 Sep 2014 12:00:43 -0400
Subject: [PATCH] ARM: mvebu: use improved armada spi device tree
 compatible name
In-Reply-To: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
References: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
Message-ID: <20140909160043.GP30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 01:30:29PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Switch the Armada SoC SPI port device tree binding to use the new improved
> armada-370-spi compatible name. This allows for a wider range of baud rates
> to be used.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/dt.

thx,

Jason.
