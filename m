From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 21 Mar 2013 10:41:17 -0400
Subject: [PATCH 08/16] thermal: mvebu: Fix temperature output formula
 for kirkwood
In-Reply-To: <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130321144117.GW13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 07:36:29PM -0300, Ezequiel Garcia wrote:
> The temperature formula was taken from the Armada 510 datasheet.
> This is wrong because the Kirkwood SoC thermal sensor has
> different coefficients.
> 
> Fix it using values from 88F682/88F683 Kirkwood datasheet.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/thermal/mvebu_thermal.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)

This is also a fix which should go at the beginning of the series.

thx,

Jason.
