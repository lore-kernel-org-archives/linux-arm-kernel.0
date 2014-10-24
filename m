From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Oct 2014 19:33:25 +0100
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141024182509.GA31232@gate.crashing.org>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <3345399.JKaCjH1LWX@wuerfel>
 <CAOesGMh3ivsvrXpKj7J8tbSXnXutXJdkfm=sbo0j_eJVAQgFsg@mail.gmail.com>
 <13842628.d0ipOeqpYt@wuerfel>
 <20141024094412.GN27405@n2100.arm.linux.org.uk>
 <20141024182509.GA31232@gate.crashing.org>
Message-ID: <20141024183325.GU27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 01:25:09PM -0500, Segher Boessenkool wrote:
> [But of course it would be good if the kernel build would work with *any*
> reasonable toolchain.  OTOH it seems that most arm toolchains aren't
> reasonable.]

It would be nice - we've passed enough flags for a long time to GCC to
try and ensure that, but GCC has a long history of changing stuff in
ways which break stuff.

It needs someone who has a foot in both camps to keep track of what's
happening in GCC, and what's needed to keep the kernel in sync.

As I tend to avoid toolchain upgrades as a rule of thumb, that person
isn't me. :)  I prefer to know where I stand with my toolchain, rather
than constantly being in the situation of having to question whether
every kernel oops is a result of a compiler bug.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
