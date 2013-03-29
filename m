From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Mar 2013 09:27:24 +0100
Subject: [PATCH] ARM: sunxi: cubieboard: Add UART muxing
In-Reply-To: <1362741536-12632-1-git-send-email-emilio@elopez.com.ar>
References: <1362741536-12632-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <5155506C.5060603@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/03/2013 12:18, Emilio L?pez a ?crit :
> We previously relied on the bootloader to do the muxing of the UART for
> the Cubieboard. Don't rely on it anymore and use pinctrl.
> 
> Also remove uart1, as it is not enabled by default and it's not exposed
> on the board headers.

Applied, thanks.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
