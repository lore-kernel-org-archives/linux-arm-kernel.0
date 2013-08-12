From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Aug 2013 17:45:49 +0100
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <CAFEAcA94ygwRPSsfxs3DvOcTZbdafLiEHys94FG4aXUx+A1t=A@mail.gmail.com>
References: <5207B3C3.9080508@roeck-us.net>
 <20130811220450.GY23006@n2100.arm.linux.org.uk> <52082EF8.10005@roeck-us.net>
 <CAFEAcA94ygwRPSsfxs3DvOcTZbdafLiEHys94FG4aXUx+A1t=A@mail.gmail.com>
Message-ID: <20130812164548.GE23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 05:24:50PM +0100, Peter Maydell wrote:
> On 12 August 2013 01:40, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 08/11/2013 03:04 PM, Russell King - ARM Linux wrote:
> >> It could be that it's qemu's PCI routing is wrong - it's not the first
> >> time that qemu has got something wrong.
> 
> QEMU 1.5 has had its Versatile PCI routing code rewritten to
> correspond with the hardware (cross-tested versus Arnd Bergmann's
> patchset
> http://marc.info/?l=linux-arm-kernel&m=128707282403376&w=2
> which was run on real versatilePB backplane hardware and
> could handle a PCI SATA card). I believe it to be correct,
> and I spent a fairly long time wading through the various bits
> of documentation and testing those kernel patches on h/w.

The documentation is totally useless - I've been through it several times
and it just doesn't give the necessary information to work out what the
routing actually is.  The only place that's documented is in the circuits,
which are impossible to get hold of (even asking ARM for them doesn't get
anywhere: basically, all information has been destroyed.)

> If somebody would like to fix the kernel I am happy to
> locate the PCI backplane and test everything (again).
> I would suggest that producing some patches which work
> with QEMU 1.5 or later would be a good start; then we
> can test on h/w as confirmation before they are applied.

If someone is willing to send me some definitive information, then
the kernel will get fixed.  All the time that there is no definitive
information, there is no point what so ever changing the kernel.

In other words, if you have the circuit diagrams or other documentation
which definitively identifies the wiring, then please send it to me.
