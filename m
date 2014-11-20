From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 20 Nov 2014 13:13:48 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <546CD90B.8060903@iki.fi>
References: <546AFEA5.9020000@samsung.com> <20141118084603.GC4059@amd>
 <546B19C8.2090008@samsung.com> <20141118113256.GA10022@amd>
 <546B40FA.2070409@samsung.com> <20141118132159.GA21089@amd>
 <546B6D86.8090701@samsung.com> <20141118165148.GA11711@amd>
 <546C66A5.6060201@samsung.com> <546CD90B.8060903@iki.fi>
Message-ID: <20141120121348.GB27527@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> But regulators already have "regulator-max-microamp" property. So what
> >> about:
> >>
> >> max-microamp :     maximum intensity in microamperes of the LED
> >>                 (torch LED for flash devices)
> >> max-flash-microamp :     initial intensity in microamperes of the
> >>               flash LED; it is required to enable support
> >>               for the flash led
> >> flash-timeout-microseconds : timeout in microseconds after which flash
> >>               led is turned off
> >>
> >> If you had indicator on the same led, I guess
> >>
> >> indicator-microamp : recommended intensity in microamperes of the LED
> >>                  for indication
> 
> The value for the indicator is maximum as well, not just a
> recommendation.

Actually, no.

This is all for one LED, if you want to use it as a flash, torch and
indicator. You already know the maximum value with max-microamp.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
