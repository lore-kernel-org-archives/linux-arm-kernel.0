From: marex@denx.de (Marek Vasut)
Date: Thu, 27 Sep 2012 02:00:57 +0200
Subject: [PATCH 2/3] ARM: dts: imx53-qsb: Make DA9053 regulator functional
In-Reply-To: <1348702057-2351-2-git-send-email-festevam@gmail.com>
References: <1348702057-2351-1-git-send-email-festevam@gmail.com>
 <1348702057-2351-2-git-send-email-festevam@gmail.com>
Message-ID: <201209270200.57482.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

[...]

> +					interrupt-parent = <&gpio7>;
> +					interrupts = <11 0x8>; /* low-level 
active IRQ at GPIO7_11 */

You mean active-low ? :-)

[...]

What was the conclusion on over-using regulator-always-on ?

Best regards,
Marek Vasut
