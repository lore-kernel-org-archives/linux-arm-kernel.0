From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 19 Aug 2015 10:09:31 +0200
Subject: [PATCH v2 19/21] leds: leds-pasic3: Add support for PASIC3 LED
 controller
In-Reply-To: <55D3A832.90705@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25ADC.10703@tul.cz>
 <55D30875.3090103@samsung.com> <55D3A832.90705@tul.cz>
Message-ID: <1439971771.11928.31.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 18.08.2015, 23:48 +0200 schrieb Petr Cvek:
> Dne 18.8.2015 v 12:27 Jacek Anaszewski napsal(a):
> > Hi Petr,
> > 
> > On 08/18/2015 12:06 AM, Petr Cvek wrote:
> > > +/*
> > > + * AIC3 (or PASIC3) LED driver for HTC Magician/Alpine/.. (not 
> > > Compaq ASIC3)
> > 
> > s/AIC3/ASIC3/
> > 
> > I am a bit confused. What's the relation between ASIC3 and PASIC3?
> 
> Actually both drivers should be renamed to AIC3 (or AIC only, as 
> there is version 2). "HTC_AIC3" is written on the chip and "pasic3" 
> is confusing with compaq asic3 driver, which claims in Kconfig help 
> to be compatible with HTC machines. Compaq ASIC3 has much more 
> functionality and from brief look it seems it has 16 bit registers 
> (HTC_AIC3 has only LEDs, RESET and DS1WM and has 8 bit registers).

I think I've got the PASIC3 name from debug strings present in the HTC
bootloader or WinCE binary. This chip (and its predecessor PASIC2 in
HTC Blueangel) are different from the ASIC3 found in hx4700 iPAQs.

regards
Philipp
