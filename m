From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 09 Jan 2016 21:53:47 +0100
Subject: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding
 documentation for bcm2835-aux-uart
In-Reply-To: <1452344854-2576-2-git-send-email-kernel@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <1452344854-2576-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <10159898.8xe3rmYdEi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 January 2016 13:07:32 kernel at martin.sperl.org wrote:
> +
> +       uart1: uart at 7e215040 {
> +               compatible = "brcm,bcm2835-aux-uart";
> +               reg = <0x7e215040 0x40>;
> +               interrupts = <1 29>;
> +               clocks = <&aux BCM2835_AUX_CLOCK_UART>;
> +       };
> 

The node name should always be "serial at ...", not "uart at ..."

	Arnd
