From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 16 Mar 2017 13:07:33 -0400
Subject: [PATCH] ARM: dts: BCM953012HR: Add ethernet aliases
In-Reply-To: <1489611575-18684-1-git-send-email-steven.lin1@broadcom.com>
References: <1489611575-18684-1-git-send-email-steven.lin1@broadcom.com>
Message-ID: <CAC3K-4pV=+Qherf-=aOAP40NUBUm680StQWo_G8M6=gmPdM5KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 4:59 PM, Steve Lin <steven.lin1@broadcom.com> wrote:
> Adding ethernet aliases.  These are used, for example, by bootloaders,
> to modify the MAC addresses in the device tree.
>
> Signed-off-by: Steve Lin <steven.lin1@broadcom.com>

LGTM

Acked-by: Jon Mason <jon.mason@broadcom.com>

> ---
>  arch/arm/boot/dts/bcm953012hr.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
> index 85f9b0b..766aa71 100644
> --- a/arch/arm/boot/dts/bcm953012hr.dts
> +++ b/arch/arm/boot/dts/bcm953012hr.dts
> @@ -41,6 +41,9 @@
>
>         aliases {
>                 serial0 = &uart0;
> +               ethernet0 = &gmac0;
> +               ethernet1 = &gmac1;
> +               ethernet2 = &gmac2;
>         };
>
>         chosen {
> --
> 2.1.0
>
