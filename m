From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 11:52:35 +0200
Subject: [PATCH RFC 3/5] ARM: dts: at91-sama5d4: use IRQ_TYPE_* to
 specify irq flags
In-Reply-To: <8bbb5802-518b-6ae1-6ea2-642b1f0b3d2e@denx.de>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-3-uwe@kleine-koenig.org>
 <8bbb5802-518b-6ae1-6ea2-642b1f0b3d2e@denx.de>
Message-ID: <20170531095235.nzkce75ffekkr65e@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/2017 at 21:17:37 +0200, Marek Vasut wrote:
> On 05/26/2017 08:06 PM, Uwe Kleine-K?nig wrote:
> > According to the binding documentation and the source code the atmel-gpio
> > controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.
> > 
> > This patch uses the right variable type which yields the same result
> > when compiled. Note that this might be wrong and actually
> > IRQ_TYPE_LEVEL_LOW is intended by the dt author.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> > ---
> > Hello,
> > 
> > can somebody with the hardware or it's documentation please check which
> > flag is the right one?
> 
> It's correct, I tested the CAN, so:
> 
> Acked-by: Marek Vasut <marex@denx.de>
> 
> > Best regards
> > Uwe
> > 
> >  arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
