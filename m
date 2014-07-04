From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 04 Jul 2014 14:25:45 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703171356.GD28175@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com> <5534788.ziUvZhb6y0@wuerfel>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com>
Message-ID: <20140704132545.7D0D7C40ADD@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jul 2014 18:13:56 +0100, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Jul 03, 2014 at 04:00:08PM +0100, Russell King - ARM Linux wrote:
> > We can have that on ARM, but only for userspace.  The difference is
> > that the kernel has to do the backwards compatibility rather than the
> > (nonexistent) CPU microcode - and we do have that capability for SWP.
> > 
> > We may not find it desirable to do it for ARMv8, but _if_ we wish to
> > allow users to migrate... if we wish to allow the existing set of
> > userspace programs (some of which may be statically linked to their
> > C library) to continue to work, there's only one option here.
> > 
> > While I can understand ARM Ltd
> 
> Please don't generalise to ARM Ltd here, even though Will and myself are
> employed by ARM. We try hard to separate the kernel maintenance
> decisions from the ARM (management) ones (in this instance, they may
> actually differ).

In case it gets lost in the heat of this debate, I have certainly
noticed that you do so and I truly appreciate it. Well done.

g.
