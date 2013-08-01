From: robherring2@gmail.com (Rob Herring)
Date: Thu, 01 Aug 2013 08:48:19 -0500
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <1375352315.22084.138.camel@shinybook.infradead.org>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1999586.84BnWE5EUh@thinkpad> <20130731191209.GA8027@netboy>
 <1409617.9untvfnOTJ@flatron> <20130731200017.GC8027@netboy>
 <20130731201457.GA24642@n2100.arm.linux.org.uk>
 <CAKON4Ow7rE9cDj_tS7kmYN4incM+ay=BK96q-ph2JxYH3xiQzg@mail.gmail.com>
 <20130731204817.GC24642@n2100.arm.linux.org.uk>
 <CAKON4Ozfe=endqnXWkcWR2HuJ489Otpcu2QsjB0DNg6jpRgG+Q@mail.gmail.com>
 <1375352315.22084.138.camel@shinybook.infradead.org>
Message-ID: <51FA6723.9010608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2013 05:18 AM, David Woodhouse wrote:
> On Wed, 2013-07-31 at 17:26 -0400, jonsmirl at gmail.com wrote:
>> Alternatively you may be of the belief that it is impossible to get
>> rid of the board specific code. But x86 doesn't have any of it, why
>> should ARM?
> 
> The reason x86 doesn't have it is because it carries three decades worth
> of legacy baggage so that it can still look like a 1980s IBM PC when
> necessary.
> 
> There *have* been some x86 platforms which abandon that legacy crap, and
> for those we *do* have board-specific code. (Is James still maintaining
> Voyager support? It feels very strange to talk about Voyager with it
> *not* being the 'legacy crap' in question...)
> 
> We've even seen *recent* attempts to abandon the legacy crap in the
> embedded x86 space, which backtracked and added it all back again ? in
> part because x86 lacked any sane way to describe the hardware if it
> wasn't pretending to be a PC. ACPI doesn't cut it, and DT "wasn't
> invented here"...
>
> Unless you want the ARM world to settle on a strategy of "all the world
> is an Assabet", I'd be careful what you wish for...

There is some level of belief that ACPI will enable running this years
OS on next years h/w. This idea is completely flawed as long as ARM
vendors don't design for compatibility, spin the Si for compatibility
issues, and have some mechanism to emulate legacy h/w. All the
discussions and issues around DT bindings and processes will apply to
ACPI bindings as well.

Rob
