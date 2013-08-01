From: vince@deater.net (Vince Weaver)
Date: Thu, 1 Aug 2013 12:02:06 -0400 (EDT)
Subject: [Ksummit-2013-discuss] [ARM ATTEND] catching up on exploit
 mitigations
In-Reply-To: <20130801025911.GA20166@redhat.com>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <20130730221435.GA22240@redhat.com>
 <20130730231120.GC30725@blackmetal.musicnaut.iki.fi>
 <20130730231533.GA26824@redhat.com>
 <20130730235834.GD30725@blackmetal.musicnaut.iki.fi>
 <20130731000444.GC1281@redhat.com>
 <20130731094012.GU24642@n2100.arm.linux.org.uk>
 <20130731142430.GA4545@redhat.com>
 <CAOesGMiBa7fT+HZquNrwV=3P=Z-F9c8L7YQr7=D2BO_6pJXQ0w@mail.gmail.com>
 <20130801025911.GA20166@redhat.com>
Message-ID: <alpine.DEB.2.02.1308011158360.11550@pianoman.cluster.toy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Dave Jones wrote:

> On Wed, Jul 31, 2013 at 07:47:30PM -0700, Olof Johansson wrote:
>  > How long would a useful run of trinity take?
> 
> It blew up in a minute or so of runtime when I tried last week.

I also have a chromebook running 3.4 and it is trivially easy to crash it 
with some simple perf_event tests I have (not the fuzzer, but just the 
regular validation tests that test counter overflow).

Like Dave, I didn't bother reporting the problem because I figured 3.4 was 
too old for anyone to care about and it was a struggle getting any 
distro/kernel installed at all on the system let alone trying to boot 
something close to current mainline on it.

Vince
