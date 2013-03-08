From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Fri, 8 Mar 2013 08:45:59 -0300
Subject: [PATCHv2 0/6] Extend UART support for Allwinner SoCs
In-Reply-To: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <BLU0-SMTP51628392EE95B57B8271B48AE60@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 07/03/13 19:14, Maxime Ripard escribi?:
> Hi,
> 
> This patchset reworks a bit the UART support that is found in the DT
> for Allwinner SoCs, which was quite limited until now.
> 
> It first switches to using the clocks property, then rework a bit the
> DTSI to have only the UART available in the A10 and the A13 (the A10
> has 8 UARTs, while A13 has only the uart1 and uart3).
> 
> Thanks,
> Maxime

The DT bits look correct to me, so

Acked-by: Emilio L?pez <emilio@elopez.com.ar>

I also tested the series on a Cubieboard (have a look at my followup
patch, "ARM: sunxi: cubieboard: Add UART muxing") and UART0 worked
correctly, so you can also have my

Tested-by: Emilio L?pez <emilio@elopez.com.ar>

for the sun4i parts.

Thanks,

Emilio
