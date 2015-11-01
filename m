From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Nov 2015 10:39:15 +0100
Subject: [PATCH] ARM: dts: sun4i: Enable audio codec on Olimex A20-SOM-EVB
In-Reply-To: <1446296142-4152-1-git-send-email-mweseloh42@gmail.com>
References: <1446296142-4152-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151101093915.GP6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 31, 2015 at 01:55:42PM +0100, Marcus Weseloh wrote:
> Enable the on-chip audio codec on the Olimex A20-SOM-EVB
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> index b7fe102..03352cc 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> @@ -86,6 +86,10 @@
>  	status = "okay";
>  };
>  
> +&codec {
> +        status = "okay";
> +};

The indentation in the DT in with tabs, and not spaces (and checkpatch
actually complains about that).

Make sure you run checkpatch before sending a new patch.

I've fixed it, and queued the patch for 4.5. Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151101/8a38dc94/attachment-0001.sig>
