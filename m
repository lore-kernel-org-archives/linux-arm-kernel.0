From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 21 Nov 2016 15:01:40 +0100
Subject: [PATCH] ARM: dts: at91: sama5d3_uart: fix reg sizes to match
 documentation
In-Reply-To: <1478764000-32233-1-git-send-email-peda@axentia.se>
References: <1478764000-32233-1-git-send-email-peda@axentia.se>
Message-ID: <20161121140140.qfr2cdgx4py46gud@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2016 at 08:46:40 +0100, Peter Rosin wrote :
> The new size (0x100) also matches the size given in sama5d3.dtsi
> 
> Documentation reference: section 43.6 "Universal Asynchronous
> Receiver Transmitter (UART) User Interface", table 43-4 "Register
> Mapping" in [1].
> 
> [1] Atmel-11121F-ATARM-SAMA5D3-Series-Datasheet_02-Feb-16
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/sama5d3_uart.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
