From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 21:58:10 +0200
Subject: [PATCH v4 1/7] ARM: lpc18xx: add basic support for NXP
 LPC18xx/43xx SoCs
In-Reply-To: <1431381653-25356-2-git-send-email-manabian@gmail.com>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <1431381653-25356-2-git-send-email-manabian@gmail.com>
Message-ID: <2541177.k9iUbnBIWD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 May 2015 00:00:47 Joachim Eastwood wrote:
> Add support for NXP's LPC18xx (Cortex-M3) and LPC43xx (Cortex-M4)
> SoCs. These SoCs are NXP's high preformance MCU line and can run at
> clock speeds up to 180 MHz for LPC18xx and 204 MHz for LPC43xx.
> 
> LPC43xx is more or less a LPC18xx with a Cortex-M4F core and a few
> extra peripherals. The LPC43xx series also features one or two
> Cortex-M0 cores that can be used to offload the main M4 core.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> 

Applied to next/soc, thanks!

	Arnd
