From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 13 Jul 2011 16:13:01 +0400
Subject: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
In-Reply-To: <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
References: <1310554738.18446.12.camel@lws-weitzel>
	<1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
Message-ID: <4E1D8BCD.5060901@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-07-2011 14:59, Jan Weitzel wrote:

> vusim is not used.

> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> ---
>   arch/arm/mach-omap2/board-omap4pcm049.c |   16 +---------------
>   1 files changed, 1 insertions(+), 15 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
> index ad8cb46..85193ec 100644
> --- a/arch/arm/mach-omap2/board-omap4pcm049.c
> +++ b/arch/arm/mach-omap2/board-omap4pcm049.c
[...]
> @@ -318,9 +306,7 @@ static struct i2c_board_info __initdata pcm049_i2c_4_boardinfo[] = {
>   	}
>   };
>
> -static struct twl4030_platform_data pcm049_twldata = {
> -	.vusim		=&pcm049_vusim,
> -};
> +static struct twl4030_platform_data pcm049_twldatai;

    Have you added that 'i' at the end intentionally?

WBR, Sergei
