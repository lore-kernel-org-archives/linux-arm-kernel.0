From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 5 Nov 2017 23:11:38 +0900
Subject: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from dtb-y
 entry
In-Reply-To: <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+CC Ralf Baechle <ralf@linux-mips.org>
+CC linux-mips at linux-mips.org
+CC Kevin Cernekee <cernekee@gmail.com>
+CC Florian Fainelli <f.fainelli@gmail.com>


I missed to CC MIPS maintainers.


2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
> we cannot build bcm96358nb4ser.dtb .
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/mips/boot/dts/brcm/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
> index 69a69d1..ad76130 100644
> --- a/arch/mips/boot/dts/brcm/Makefile
> +++ b/arch/mips/boot/dts/brcm/Makefile
> @@ -22,7 +22,6 @@ dtb-$(CONFIG_DT_NONE) += \
>         bcm63268-comtrend-vr-3032u.dtb \
>         bcm93384wvg.dtb \
>         bcm93384wvg_viper.dtb \
> -       bcm96358nb4ser.dtb \
>         bcm96368mvwg.dtb \
>         bcm9ejtagprb.dtb \
>         bcm97125cbmb.dtb \
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
