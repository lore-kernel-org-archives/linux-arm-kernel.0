From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 15 Oct 2015 23:30:33 +0200
Subject: [PATCH] ARM: dts: berlin: fix typo in chosen property
In-Reply-To: <1444734729-4818-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1444734729-4818-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <56201AF9.5010600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.10.2015 13:12, Michael Opdenacker wrote:
> This fixes a trivial typo in the name of the "chosen" device tree property
> for the Marvell BG2-Q DMP board.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

Applied to berlin/fixes with Antoine's Acked-by and
a Cc to stable back to v3.16.

Thanks,
   Sebastian

> ---
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index 4a749e5b3b44..caeeb345c335 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -48,7 +48,7 @@
>   		reg = <0x00000000 0x80000000>;
>   	};
>
> -	choosen {
> +	chosen {
>   		bootargs = "console=ttyS0,115200 earlyprintk";
>   	};
>
>
