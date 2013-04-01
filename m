From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 1 Apr 2013 11:57:24 -0400
Subject: [PATCH] Fix typo in the definition of ix2-200 rebuild LED
In-Reply-To: <1364817802-7889-2-git-send-email-nigel@nobiscuit.com>
References: <1364817802-7889-1-git-send-email-nigel@nobiscuit.com>
 <1364817802-7889-2-git-send-email-nigel@nobiscuit.com>
Message-ID: <20130401155724.GO13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 11:03:22PM +1100, Nigel Roberts wrote:
> In the conversion to pinctrl, an error in the pins for the rebuild
> LED was introduced. This patch assigns the correct pins and includes
> the correct name for the LED in kirkwood-iomega_ix2_200.dts.
> 
> Signed-off-by: Nigel Roberts <nigel@nobiscuit.com>
> ---
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied to mvebu/fixes, also flagged it for -stable, v3.8.x

thx,

Jason.
