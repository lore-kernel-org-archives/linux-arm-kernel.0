From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 3 Aug 2015 08:59:15 +0200
Subject: [RFC PATCH 2/3] ARM: at91/dt: add sama5d2 pinmux
In-Reply-To: <55BF0CD2.5030204@atmel.com>
References: <1438355290-28255-1-git-send-email-ludovic.desroches@atmel.com>
 <1438355290-28255-3-git-send-email-ludovic.desroches@atmel.com>
 <55BF0CD2.5030204@atmel.com>
Message-ID: <20150803065915.GF4055@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Mon, Aug 03, 2015 at 02:40:18PM +0800, Josh Wu wrote:
> Hi, Ludovic
> 
> On 7/31/2015 11:08 PM, Ludovic Desroches wrote:
> >Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >---
> >  arch/arm/boot/dts/sama5d2-pinfunc.h | 760 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 760 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sama5d2-pinfunc.h
> >
> >diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
> >new file mode 100644
> >index 0000000..046d1d5
> >--- /dev/null
> >+++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
> >
> 
> [snip...]
> 
> >+#define PIN_PB24__FLEXCOM3_IO3		PINMUX_PIN(PIN_PB24, 5, 3)
> >+#define PIN_PB24__ISI_D10		PINMUX_PIN(PIN_PB24, 6, 3)
> 
> As sama5d2 use ISC, so It's better to run  s/ISI_/ISC_/ in this file, which
> is consistent with the datasheet.
>

Ok, the one I used was a bit older and was still with ISI instead of
ISC. I'll update this file.

Regards

Ludovic
