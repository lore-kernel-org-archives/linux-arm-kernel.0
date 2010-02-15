From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 15 Feb 2010 22:20:43 +0800
Subject: [PATCH 2/2] pxa/imote2: Remove redundant pin entry for nCS.
In-Reply-To: <1266094772-2776-2-git-send-email-stefan@datenfreihafen.org>
References: <1266094772-2776-1-git-send-email-stefan@datenfreihafen.org>
	<1266094772-2776-2-git-send-email-stefan@datenfreihafen.org>
Message-ID: <f17812d71002150620l206e4512h44750d7a19d065ce@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 14, 2010 at 4:59 AM, Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> Also remove a trailing whitespace while being there.
>
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Applied to 'devel', thanks.

> ---
> ?arch/arm/mach-pxa/imote2.c | ? ?3 +--
> ?1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/imote2.c b/arch/arm/mach-pxa/imote2.c
> index 5b0862d..b2f878b 100644
> --- a/arch/arm/mach-pxa/imote2.c
> +++ b/arch/arm/mach-pxa/imote2.c
> @@ -64,7 +64,6 @@ static unsigned long imote2_pin_config[] __initdata = {
> ? ? ? ?GPIO116_GPIO, ? ? ? ? ? ? ? ? ? /* CC_CCA */
> ? ? ? ?GPIO0_GPIO, ? ? ? ? ? ? ? ? ? ? /* CC_FIFOP */
> ? ? ? ?GPIO16_GPIO, ? ? ? ? ? ? ? ? ? ?/* CCSFD */
> - ? ? ? GPIO39_GPIO, ? ? ? ? ? ? ? ? ? ?/* CSn */
> ? ? ? ?GPIO115_GPIO, ? ? ? ? ? ? ? ? ? /* Power enable */
>
> ? ? ? ?/* I2C */
> @@ -72,7 +71,7 @@ static unsigned long imote2_pin_config[] __initdata = {
> ? ? ? ?GPIO118_I2C_SDA,
>
> ? ? ? ?/* SSP 3 - 802.15.4 radio */
> - ? ? ? GPIO39_GPIO, ? ? ? ? ? ? ? ? ? ?/* Chip Select */
> + ? ? ? GPIO39_GPIO, ? ? ? ? ? ? ? ? ? ?/* Chip Select */
> ? ? ? ?GPIO34_SSP3_SCLK,
> ? ? ? ?GPIO35_SSP3_TXD,
> ? ? ? ?GPIO41_SSP3_RXD,
> --
> 1.6.6.2
>
>
