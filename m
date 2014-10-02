From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 11:24:54 +0200
Subject: [PATCH 1/6] ARM: meson: add meson8 machine definition
In-Reply-To: <1412198986-26534-2-git-send-email-b.galvani@gmail.com>
References: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
 <1412198986-26534-2-git-send-email-b.galvani@gmail.com>
Message-ID: <11073411.IcmTkIICYA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 23:29:41 Beniamino Galvani wrote:
> 
> +static const char * const m8_common_board_compat[] = {
> +       "amlogic,meson8",
> +       NULL,
> +};
> +
>  DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
>         .dt_compat      = m6_common_board_compat,
>  MACHINE_END
>  
> +DT_MACHINE_START(MESON8, "Amlogic Meson8 platform")
> +       .dt_compat      = m8_common_board_compat,
> +MACHINE_END
> 

I'd just add the meson8 string to the m6_common_board_compat list and
rename it.

	Arnd
