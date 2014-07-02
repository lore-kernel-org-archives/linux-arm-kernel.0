From: dalias@libc.org (Rich Felker)
Date: Wed, 2 Jul 2014 17:16:20 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <53B18462.3040700@codeaurora.org>
References: <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <20140627223328.GB17988@brightrain.aerifal.cx>
 <20140627230736.GX32514@n2100.arm.linux.org.uk>
 <CALCETrVFvYNPHMozB2E2L0LWSPv=o6JHfmoz4_pBC2gQwRLpug@mail.gmail.com>
 <20140627233505.GA32514@n2100.arm.linux.org.uk>
 <CALCETrVOabOU=NMz-GO1L_iu5QgVYoUOrYMzDDBMxYRy4W69ag@mail.gmail.com>
 <53B18462.3040700@codeaurora.org>
Message-ID: <20140702211620.GX179@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 11:38:10AM -0400, Christopher Covington wrote:
> On 06/27/2014 07:40 PM, Andy Lutomirski wrote:
> 
> > If you ever want an ARM vdso (e.g. for timing), I'd be happy to help
> > and try to share code with x86.
> 
> http://www.spinics.net/lists/arm-kernel/msg340661.html

Great! Please let us know when this makes it into the official kernel
(so we have some assurance the interface is stable) and I'll add
support in musl as soon as we can find a system to test it on. Unless
there's any gratuitous incompatibility with vdso on other archs,
adding it on our side should be just a three-line patch to
arch/arm/syscall_arch.h.

Rich
