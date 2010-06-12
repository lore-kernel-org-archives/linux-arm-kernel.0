From: david-b@pacbell.net (David Brownell)
Date: Sat, 12 Jun 2010 10:34:37 -0700 (PDT)
Subject: [PATCH 1/5] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <AANLkTimHDBI0grgNrcvZ-BWS9kd0z4lFqEgVoyM4ysVJ@mail.gmail.com>
Message-ID: <73954.66622.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Sat, 6/12/10, Eric Miao <eric.y.miao@gmail.com> wrote:

> From: Eric Miao <eric.y.miao@gmail.com>
> Subject: Re: [PATCH 1/5] usb/otg/ulpi: extend the generic ulpi driver.
> To: "Igor Grinberg" <grinberg@compulab.co.il>


Isn't this patch From: Igor?

It arrived in my mailbox a bit mangled.

A quick scan suggests its OK, but I can't test
or evanulate it just now, e.g. to see if it
breaks anything else, builds, etc.  Plus, I've
not looked at this driver.

Felipe, got any comments?  Is this driver generic
enough that MUSB could use it for ULPI access?
