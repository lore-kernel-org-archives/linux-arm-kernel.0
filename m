From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Feb 2012 20:26:52 +0100
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <4F302474.1020701@firmworks.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
 <4F302474.1020701@firmworks.com>
Message-ID: <CACRpkdYt-L+an5DTdYkS5Hi+18-rszAt7hXwZNUNVK-d0UaCWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2012 at 8:05 PM, Mitch Bradley <wmb@firmworks.com> wrote:

> I like the general approach of simplifying the pinctrl thing, as the
> previous approach did not appear to be converging.

pinctrl as such is upstream, widely ACKed and quite converged I'd say.

But the Device Tree bindings and general path to get data out of the drivers
and board files are not (yet) converging...

> Both Open Firmware and ACPI have addressed this general problem. ?In
> addition to a numeric identifier for the register, you need to specify the
> access semantics. ?It's difficult to finitely enumerate all possible cases,
> but you can get to 99.9% with a modest number of access models, and then add
> new models as needed.

This is interesting. So are you referring to a piece of Open Firmware
that is not in the Device Tree? Since this is all about device tree that
comes from OF, we might be reinventing the wheel.
Can you give some pointers?

Indeed it seems related to ACPI or some BIOS stuff on
non-embedded systems.

Yours,
Linus Walleij
