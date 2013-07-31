From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Jul 2013 00:38:03 -0700
Subject: [ATTEND] [ARM ATTEND] kernel data bloat and how to avoid it
Message-ID: <20130731073802.GT7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Probably the biggest kernel data bloat issue is in the ARM land, but
it also seems that it's becoming a Linux generic issue too, so I
guess it could be discussed in either context.

The kernel data bloat issue is slightly related to the devicetree talks
as well as I'm seeing a lot of the device tree bindings heading the wrong
way both at the binding level and the device driver level.

Basically the data bloat issue is there for the arch code and drivers
and may not show up initially until things have headed the wrong way for
too long.

After struggling with the data issues in the ARM land over past few
years, I think we have now pretty good idea how to spot the issues
early and avoid building databases into Linux kernel.

So some kind of discussion on data bloat and how to avoid it might be
interesting to a bunch of maintainers?

Regards,

Tony
