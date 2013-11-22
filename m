From: jonathan@jonmasters.org (Jon Masters)
Date: Fri, 22 Nov 2013 15:59:45 -0500
Subject: ACPI
In-Reply-To: <201311222131.08787.arnd@arndb.de>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <201311220129.54828.arnd@arndb.de> <528ED801.8040705@jonmasters.org>
 <201311222131.08787.arnd@arndb.de>
Message-ID: <528FC5C1.1080403@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2013 03:31 PM, Arnd Bergmann wrote:
> On Friday 22 November 2013, Jon Masters wrote:
> 
>> By 64-bit ARM server, I mean a system conformant with a series of
>> specifications that define what such a server system consists of. It
>> might be a physical system featuring an ARM-based SoC containing a core
>> conformant to the v8 Architecture, along with standardized peripherals,
>> or it might be a virtual platform. The boot architecture would include
>> UEFI (specifically a sequential progression from an initial EL3 reset
>> secure ROM on through to a verified Tiano build), and ACPI being used to
>> convey the platform devices, as well as for runtime event delivery.
> 
> Ok, that narrows it down a little, although not in the way I expected.
> 
> It seems there is a secret spec along the lines of the older PREP, CHRP,
> PAPR. Since the group behind this spec has not yet revealed itself, I will
> refer to them as SPECTRE (maybe that should be SPCTR?) for the sake of
> discussion.

That's an *awesome* choice of name. Made my afternoon :) If there were
an organization such as SPECTRE, I really hope that it would come with
those lap cats (I seem to be missing mine - but I do have a stuffed
plush white toy cat in my Amazon wishlist, and a birthday coming..).

But regardless of the existence or otherwise of any organization, I
would expect to see some standards documents appearing in the not too
distant future. I share the concern that this stuff needs to be out in
public, but above all, all else, what I care about above all is that
when there are ARM server systems in market in the next few years that
you can run *any* one-size-fits-all generic Operating System you would
like to choose to run, and freely move from one OS to another. That
includes the ability to run generic Linux distributions, Hypervisors,
non-Unix Operating Systems, and so on. To do that requires that the
underlying server platform be standardized in the same way that it is
elsewhere on other arches, with sensitivity to a wide world of choice.

A few years ago, a strategic direction was chosen by a few industry
players around UEFI and ACPI on ARM. I look forward to seeing standards
published, to seeing more emerging members of this market announced
their intentions, and to an engaging dialog about how support for these
systems will be implemented so that there is one standardized 64-bit ARM
server platform upon which customers can run anything they want. I hope
we can have some really engaging conversation very soon about it.

Thanks,

Jon.
