From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Nov 2013 13:19:48 +0000
Subject: ACPI
In-Reply-To: <201311220129.54828.arnd@arndb.de>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <201311191915.57516.arnd@arndb.de>
 <20131121200344.GD14725@sirena.org.uk>
 <201311220129.54828.arnd@arndb.de>
Message-ID: <20131122131948.GM14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 01:29:54AM +0100, Arnd Bergmann wrote:
> On Thursday 21 November 2013, Mark Brown wrote:

> > I'd also ask if we need to consider desktops and laptops here - do we
> > really mean distros here rather than servers, even if servers are the
> > primary use case for distros right now?

> Jon has previously said (multiple times) that he cares about servers
> only, so I assume that is still given. If you take the exact same

Ah, I'd not seen that - but of course there are a bunch of different
and overlapping userbases out there each with their own focuses.

> hardware and firmware and add a PCIe GPU to turn it into a workstation
> or laptop, I don't see that change anything from the kernel perspective,
> but I'm trying to narrow the scope here, not widen it ;-)

Indeed.  I'd be surprised if people built too many systems that way
though, especially laptops.

I'm perfectly prepared to believe that the answer here is that nobody
cares about ACPI on anything other than some subset of servers (which
will depend in part on what people see ACPI doing for them) but I figure
it's important to ask the question, especially given that Intel seem to
be deploying more embedded style hardware in these applications - Linux
may have to cope with these cases anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/5c1556c1/attachment.sig>
