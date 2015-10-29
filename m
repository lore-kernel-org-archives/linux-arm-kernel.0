From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 14:43:15 +0300
Subject: [PATCH v3 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <CAJKOXPcSehXRYDpYiybzdagPS76QKGpeMb7DxkpwJq8GTfuPOw@mail.gmail.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
 <046d990092dc85cf50db9082fc894d93a3ece7c0.1446018918.git.p.fedin@samsung.com>
 <563183F9.6020806@samsung.com> <008001d1121d$c0fef160$42fcd420$@samsung.com>
 <CAJKOXPcSehXRYDpYiybzdagPS76QKGpeMb7DxkpwJq8GTfuPOw@mail.gmail.com>
Message-ID: <003c01d1123f$002a3220$007e9660$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >> Any vendor prefix here? How generic is this?
> >
> >  I just don't know... Does *everything* really need a vendor prefix? How readable would that
> be? "compatible" property already says
> > that it's samsung-exynos-specific. And IMHO it's quite obvious that properties of vendor-
> specific device are automatically
> > vendor-specific.
> >  Ok, i am currently fixing up the rest and will post v4 soon, and will Cc: it to devicetree
> ML.
> 
> Which my reply you are referring to? You stripped part of some
> sentence and put it without *any context*. Just random sentence.
> I asked for vendor prefix in few places... srom-timing? width? And I
> do not remember where I used exactly these words.

 Ok, sorry, i promise to improve. :)
 Anyway, i have figured out how to add sub-devices, and heavily modified the whole thing. And indeed, vendor prefix is now very useful, so i added it to all three properties. Making v4...

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
