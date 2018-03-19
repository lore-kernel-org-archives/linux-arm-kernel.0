From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 19 Mar 2018 17:22:35 +0100
Subject: [PATCH] arm64: dts: armada-3720-espressobin: Document URL for
 schematic
In-Reply-To: <20180316100124.29972-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Fri, 16 Mar 2018 11:01:24
 +0100")
References: <20180316100124.29972-1-u.kleine-koenig@pengutronix.de>
Message-ID: <87vadsxcfo.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On ven., mars 16 2018, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> The schematic of hte espressobin is publicly available, add a comment
> where to find it.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied on mvebu/dt64 with the Reviewed-by from Andrew Lunn and the typo
fixed.

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index bdfb5553ddb5..6d070b267abe 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -42,6 +42,9 @@
>   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   *     OTHER DEALINGS IN THE SOFTWARE.
>   */
> +/*
> + * Schematic available at http://espressobin.net/wp-content/uploads/2017/08/ESPRESSObin_V5_Schematics.pdf
> + */
>  
>  /dts-v1/;
>  
> -- 
> 2.16.2
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
