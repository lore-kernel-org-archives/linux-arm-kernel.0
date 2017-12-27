From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Dec 2017 21:01:47 +0100
Subject: [PATCH] Device tree binding for Avago APDS990X light sensor
In-Reply-To: <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
Message-ID: <20171227200147.GB16799@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +Required properties:
> > +- compatible: "avago,apds990x"
> > +- reg: address on the I2C bus
> > +- interrupts: external interrupt line number
> > +- Vdd-supply: power supply for VDD
> > +- Vled-supply: power supply for LEDA
> 
> AFAIK the custom is to use lower case letters for regulator supplies.
> 
> > +- ga: Glass attenuation
> > +- cf1: Clear channel factor 1
> > +- irf1: IR channel factor 1
> > +- cf2: Clear channel factor 2
> > +- irf2: IR channel factor 2
> > +- df: Device factor
> > +- pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
> > +- ppcount: Proximity pulse count
> 
> Are these device specific? If so, please add the vendor prefix to them.

Well, whole binding is "vendor specific". Does it make sense to add
prefix in such case?

> I might not use short abbreviations such as "df" either. I wonder what
> others think.

I see.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171227/ff1c47f7/attachment.sig>
