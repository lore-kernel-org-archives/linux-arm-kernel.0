From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 24 Nov 2013 18:14:07 +0100
Subject: ACPI
In-Reply-To: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
Message-ID: <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 7:42 PM, Jon Masters <jonathan@jonmasters.org> wrote:

> Could we articulate a series of useful asks that would help with moving
> forward with ACPI? For example, it is clear that there needs to be
> more involvement in the standardization of ACPI (...)

One thing I think a bit about is ontology[1], what is written in that
spec and under what assumptions. I noticed from DSDT fragments
here and there that ACPI has no concept of pin control, but instead
adhere to the old fallacy of mixing this up with GPIO in the examples
I saw, and this would be good to have clarified, maybe I as a
subsystem maintainer need to go read some spec and provide
feedback on it?

For devicetree we have a bit of standardization in
Documentation/devicetree/bindings/pinctrl and if I'm not mistaken,
nothing of the sort exist in the ACPI spec.

The same can probably be said about slave DMA,
Documentation/devicetree/bindings/pinctrl?
Or regulators? Clocks? Runtime PM and D-states as
Arnd mentioned?

In which cases does the ACPI definitions of terms, paradigms and
ontologies match those if the kernel subsystems, and where will
we be shoehorned into somebody else's idea of the world, and
is there something we can do about it (i.e. influcence this).

Yours,
Linus Walleij

[1] Using this in the exact philosophical sense to be precise with
the problem I have, not trying to play smart.
Quote from Wikipedia:
" ontology deals with questions concerning what entities exist or
 can be said to exist, and how such entities can be grouped,
 related within a hierarchy, and subdivided according to similarities
 and differences"
