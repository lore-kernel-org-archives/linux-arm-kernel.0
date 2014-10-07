From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Oct 2014 13:17:40 +0100
Subject: [PATCH v3 1/4] Documentation: devicetree: bindings: Document
 correct and deprecated vendor-prefix with device isl29028
In-Reply-To: <20141007120249.GH24725@leverpostej>
References: <1412682308-8784-1-git-send-email-darshanapadmadas@gmail.com>
 <1412682308-8784-2-git-send-email-darshanapadmadas@gmail.com>
 <20141007120249.GH24725@leverpostej>
Message-ID: <20141007121740.GL24725@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 01:02:49PM +0100, Mark Rutland wrote:
> On Tue, Oct 07, 2014 at 12:45:05PM +0100, Darshana Padmadas wrote:
> > This patch documents the device isl29028 with its vendor-prefix. Undocumented deprecated vendor-prefix
> > found by checkpatch also documented for compatibility reasons.
> > 
> > Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> > ---
> >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > index 6af570e..d024613 100644
> > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > @@ -57,6 +57,8 @@ gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire In
> >  infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
> >  infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> >  isl,isl12057		Intersil ISL12057 I2C RTC Chip
> > +isil,isl29028           Deprecated name, use isl,isl29028 instead

Looking again, could you change the comment to "(deprecated, use isl)",
as I mentioned previously?

Then that will match what we have for powervr, which seems to be the
only other instance of "deprecated" in vendor-prefixes.txt.

Cheers,
Mark.

> > +isl,isl29028            Intersil ISL29028 Ambient Light and Proximity Sensor
> >  maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
> >  maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
> >  maxim,max6625		9-Bit/12-Bit Temperature Sensors with I??C-Compatible Serial Interface
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
