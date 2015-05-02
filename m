From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Sat, 2 May 2015 08:51:38 +0200
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <20150428181109.GA4027@n2100.arm.linux.org.uk>
References: <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth> <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth> <20150420234032.GM18048@atomide.com>
 <20150423102542.GZ4027@n2100.arm.linux.org.uk>
 <CAALWOA_3wfn=K3qt9MzWYXMGTM7mZvqY03Biqk5T2wVF4uMVxQ@mail.gmail.com>
 <20150428181109.GA4027@n2100.arm.linux.org.uk>
Message-ID: <CAALWOA-3_4jpdwY-D07i1_Q0Q2sLsYXSEoJXX7+stnXBZR7yqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2015 at 20:11, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> "Can't detect" is _not_ an overstatement.  It's a statement that I'm
> giving you through my experience and knowledge of the Linux kernel,
> the ARM archtecture, the capabilities of the platforms we have to
> deal with, and how we want the kernel to work.
>
> Sure, we _can_ detect it if (and only if) we code specifically for a
> platform which has RAM at the CPU vector location.  Unfortunately,
> that's a _very_ small proportion which approximates a number very
> close to zero.

Sorry, I clearly had never adequately appreciated how much of a luxury
it is to be targeting only a limited range of platforms, or the burden
of the constraints imposed by needing to support the bewildering
diversity out there.

However, your objection isn't quite valid either since any ARM cpu
supporting the security extensions also supports changing the vector
base address.

Matthijs
