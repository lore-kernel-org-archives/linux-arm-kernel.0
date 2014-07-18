From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Jul 2014 16:58:53 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <CAFEAcA-jdVxgUY03j12HDWzKwtVaxsmL-AarD5QyNb1jmYEa2g@mail.gmail.com>
References: <20140717105415.GI21153@arm.com>
 <CAFEAcA8wZ9z8+0Q-2D_B3tkuQnksdWFeWEAadkHyB72oS6ae=A@mail.gmail.com>
 <20140717123533.GJ21153@arm.com>
 <CAFEAcA_ZXDDRycNVXmw1FSgRFiPgtB_2qqe-ioj91jMeBJR7PQ@mail.gmail.com>
 <20140717171058.GM18203@arm.com> <20140717172858.GD4844@arm.com>
 <20140718092744.GA19850@arm.com> <20140718095311.GA1818@arm.com>
 <20140718135738.GA17328@leverpostej>
 <CAFEAcA-jdVxgUY03j12HDWzKwtVaxsmL-AarD5QyNb1jmYEa2g@mail.gmail.com>
Message-ID: <20140718155852.GB16376@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 04:52:37PM +0100, Peter Maydell wrote:
> On 18 July 2014 14:57, Mark Rutland <mark.rutland@arm.com> wrote:
> > Comments are added to guide userspace developers in the right direction
> > (using the hwcaps provided in auxval). Hopefully where userspace
> > applications parse /proc/cpuinfo rather than using the readily available
> > hwcaps, they limit themselves to reading said first line.
> 
> Comments in the kernel sources aren't going to guide
> anybody except kernel developers.

That's not entirely true, some people skim the kernel sources to figure
out how they're meant to use syscalls and such (though admitedly this
isn't all that common).

> I was expecting from this commit message that you were going to emit
> actual comments in /proc/cpuinfo...

I don't think that's a good idea, and I can only see that reading when I
squint quite hard. ;)

Thanks,
Mark
