From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Nov 2012 21:23:42 +0000
Subject: [Patch v6 4/4] ASoC: at91sam9g20ek-wm8731: convert to dt support
In-Reply-To: <1352887751-21848-5-git-send-email-voice.shen@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-5-git-send-email-voice.shen@atmel.com>
Message-ID: <201211262123.42812.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 November 2012, Bo Shen wrote:
> +
> +                       ssc0: ssc at fffbc000 {
> +                               status = "okay";
> +                               pinctrl-0 = <&pinctrl_ssc0_tx>;
> +                       };
>                 };
>  

This gives me a build error in linux-next with at91sam9g20_defconfig:

ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"

	Arnd
