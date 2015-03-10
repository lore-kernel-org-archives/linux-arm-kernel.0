From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 16:08:59 +0100
Subject: [PATCH v2 12/18] dt-bindings: Document the STM32 USART bindings
In-Reply-To: <1424455277-29983-13-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-13-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <38153432.AWA0ogMaoK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 February 2015 19:01:11 Maxime Coquelin wrote:
> +
> +Example:
> +usart1: usart at 40011000 {
> +       compatible = "st,stm32-usart";
> 

Please use generic node names everywhere. The standard name for a serial
port is "serial".

	Arnd
