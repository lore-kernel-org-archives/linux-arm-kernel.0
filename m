From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Apr 2016 22:09:21 +0200
Subject: [PATCH 1/2] arm64: dts: uniphier: fix I2C nodes of PH1-LD20
In-Reply-To: <1460716247-28049-2-git-send-email-yamada.masahiro@socionext.com>
References: <1460716247-28049-1-git-send-email-yamada.masahiro@socionext.com>
 <1460716247-28049-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <4326944.O9ELFsuto4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 19:30:46 Masahiro Yamada wrote:
> The I2C hardware blocks on this SoC are connected as follows:
> 
>   I2C0: external connection
>   I2C1: external connection
>   I2C2: internal connection
>   I2C3: external connection
>   I2C4: external connection
>   I2C5: internal connection
>   I2C6: no connection (not accessible)
> 
> Delete pinctrl from Ch2, add pinctrl to Ch4, and remove the Ch6 node.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 


Applied patch 1/2 to the fixes branch now, thanks!

	Arnd
