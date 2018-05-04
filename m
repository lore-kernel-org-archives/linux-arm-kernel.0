From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 4 May 2018 23:47:23 +0200
Subject: Motorola Droid 4 progress, power consumption
In-Reply-To: <20180504203819.GF98604@atomide.com>
References: <20180501183148.GA26996@amd> <20180502144158.GJ98604@atomide.com>
 <20180503090611.GA14451@amd> <20180503142240.GQ98604@atomide.com>
 <20180504202044.GC22519@amd> <20180504203819.GF98604@atomide.com>
Message-ID: <20180504214723.GA8010@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > But I guess I can sample charge_counter every minute or so and get
> > what I need?
> 
> Not sure what the max time range is for the PMIC, but yeah I'd
> assume once a minute is duoable. Maybe compare it to the chart
> you already have?

Yes, I can try some more graph painting.

OTOH... battery life is "good enough" and I can already tell when the
battery is full :-). So this part is not critical.

> > I agree this should not be done in kernel as it requires persistent
> > storage.
> > 
> > Battery is not user-replacable (and this will recalibrate itself on
> > charge/discharge cycle) so.. I don't think keying is strictly
> > neccessary for D4.
> 
> Yeah right, that can be added later on if needed if you just
> plan accordingly. It's replaceable with a T5 after you peel off the
> sticker from the corners :)

Aha, I wanted to ask what kind of phone T5 is, and T5 is probably torx
5 screwdriver, right? Well, I don't have second battery, so these
experiments will have to wait.

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/43e08e08/attachment.sig>
