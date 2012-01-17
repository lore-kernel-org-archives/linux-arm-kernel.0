From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Jan 2012 10:32:11 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <CACRpkdYmxQd7aaRhs+xc5nizC7OjwRzsduq-28kVTLjhTGjVZw@mail.gmail.com>
References: <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <20120107135445.GI4790@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A6E5@HQMAIL01.nvidia.com>
 <20120112033941.GH20968@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1DCC@HQMAIL01.nvidia.com>
 <20120113034558.GA12184@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1F9D@HQMAIL01.nvidia.com>
 <20120114012213.GD1810@S2101-09.ap.freescale.net>
 <CACRpkdYmxQd7aaRhs+xc5nizC7OjwRzsduq-28kVTLjhTGjVZw@mail.gmail.com>
Message-ID: <20120117023206.GA11756@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 05:08:57PM +0100, Linus Walleij wrote:
...
> As you can see none of the text above claims that the group is
> about hardware-defined groups or anything like that. The groups
> are just that - a group of pins, an abstract concept of a group.

Ok, the thing gets clarified.  The concept of group is a abstract at
software level.  It does not necessarily require a pin group defined
by raw hardware underneath, which is basically my argument.

> It could be drawn i UML even... maybe I'll do that for my
> ELC presentation :-)
> 
> Then when we come to pinmux, which is slightly different
> involving the definitions of a function and mappings between
> functions and one or more pin groups as per above, which is
> something completely different and seems to be what you're
> discussing here?
> 
> For hardware that does handle pins in groups there are
> special functions that can be used in the drivers like
> configuring a whole group (which falls back to iterating
> over pins if there is no such callback, showing again that
> this is a theoretical concept) so if the hardware handles
> pins in groups its a good idea to match group definitions
> 1-to-1 with these, but for hardware that doesn't there is
> some freedom of how to use the groups.
> 
> I don't know if this helps though the discussion here seems
> a bit contended :-/
> 
It does help to me.  Thanks, Linus.

-- 
Regards,
Shawn
