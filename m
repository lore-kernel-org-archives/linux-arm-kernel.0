From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Apr 2015 01:34:37 +0200
Subject: [PATCH v2 2/7] ARM: at91/dt: at91-kizbox: sanitize file
In-Reply-To: <1429617918-32086-3-git-send-email-g.portay@overkiz.com>
References: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
 <1429617918-32086-3-git-send-email-g.portay@overkiz.com>
Message-ID: <20150428233437.GI3687@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2015 at 14:05:13 +0200, Ga?l PORTAY wrote :
> Consists in:
>  * sorting nodes by address as possible or alphabetically,
>  * adding myself as new maintainer and
>  * update license.
> 
> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
> ---
>  arch/arm/boot/dts/at91-kizbox.dts | 67 +++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
> index e83e4f9..00c86c1 100644
> --- a/arch/arm/boot/dts/at91-kizbox.dts
> +++ b/arch/arm/boot/dts/at91-kizbox.dts
> @@ -1,16 +1,16 @@
>  /*
> - * kizbox.dts - Device Tree file for Overkiz Kizbox board
> + * at91-kizbox.dts - Device Tree file for Overkiz Kizbox board
>   *

My guess is that this should be part of the previous patch


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
