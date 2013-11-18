From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 18 Nov 2013 21:32:56 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131118190929.GA5886@quad.lixom.net>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131115095717.GC1709@e106331-lin.cambridge.arm.com> <5289A356.
 4060004@jonmasters.org> <20131118190929.GA5886@quad.lixom.net>
Message-ID: <20131118213256.8EC15C401C6@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 11:09:29 -0800, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Nov 18, 2013 at 12:19:18AM -0500, Jon Masters wrote:
> 
> I'm looking at the quality of the initial submissions (very poor and
> confused), the readiness of the kernel in general (none so far),
> the way the involved parties are doing development (away from the
> community and in their own little world). I also look at some of the
> bottlenecks we've had with device tree (reviewer bandwidth, slow-moving
> consensus/standards-driven approval process) and how it compares to the
> ACPI counterparts (standards forum).
> 
> The conclusion is that we're about to embark onto something that isn't
> going to be done right in the short to medium term. It just isn't. The
> sooner we own up to that, the sooner we can course-correct and get back
> to something that's likely to work.
> 
> The alternative is signing onto a setup that _will_ stumble right out
> of the door, which in turn will mean that the high-end ARM play will be
> off to a rough start instead of running as smoothly as possible.

I completely agree here. The DT conversion was hard and it took a lot of
years. There was a lot of getting the code into shape and a lot of
people trying to get their heads around it. ACPI is exactly the same
problem. We don't know what we're doing and we don't know how to do it
yet.

I fully support getting ACPI up on ARM and the current work is good.
However, it cannot short-circuit the kernel development process.
Absolutely, push back hard on the ACPI and UEFI patches where the code
is not ready.

g.
