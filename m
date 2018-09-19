From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 19 Sep 2018 19:11:20 +0200
Subject: [PATCH] ARM: dts: at91: sama5d27_som1_ek: add adc regulators
In-Reply-To: <1537360793-10264-1-git-send-email-eugen.hristev@microchip.com>
References: <1537360793-10264-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180919171120.GE2479@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2018 15:39:53+0300, Eugen Hristev wrote:
> Add fixed regulators for the ADC. This board does not have
> a programmable PMIC, but fixed regulators.
> Adding them to DT so the ADC can probe correctly.
> 
> Tested-by: Swapna Gurumani <swapna.gurumani@microchip.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 42 +++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
