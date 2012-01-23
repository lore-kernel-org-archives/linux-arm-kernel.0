From: petter@neppe.no (Petter Nordby)
Date: Mon, 23 Jan 2012 14:07:17 +0100
Subject: [PATCH 1/1] ARM: Developed device driver for Atmel TSADC
 controller
In-Reply-To: <4F1D49EE.6020600@atmel.com>
References: <n> <1327317907-2874-1-git-send-email-pettno@gmail.com>
 <20120123113647.GX1068@n2100.arm.linux.org.uk> <4F1D49EE.6020600@atmel.com>
Message-ID: <4F1D5B85.6050406@neppe.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2012 12:52 PM, Nicolas Ferre wrote:
> But as Russell suggested, this use of ADC for AT91SAM9G45 family (TSADC)
> will be better suited for the IIO subsystem.
> A new AT91 ADC driver designed for this IIO subsystem has been developed
> a little time ago:
> "[PATCH RESEND v13] AT91: Add a driver for the ADC"
>
> It will likely be included shortly in mainline kernel. I advice to
> follow this development and add the support of SAM9G45 ADC to this
> existing infrastructure.

Thanks for pointing me in this direction. Exactly what I need.
I'm really looking forward to getting it in mainline kernel.

Best regards,
Petter Nordby
