From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Feb 2016 15:40:28 +0100
Subject: next-20160225 build: 2 failures 44 warnings (next-20160225)
In-Reply-To: <20160226121220.GO18327@sirena.org.uk>
References: <E1aYsmb-0006qb-76@optimist> <20160226030949.GL18327@sirena.org.uk>
 <20160226091410.5dad4306@free-electrons.com>
 <20160226121220.GO18327@sirena.org.uk>
Message-ID: <20160227154028.60f2cfca@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Fri, 26 Feb 2016 21:12:20 +0900, Mark Brown wrote:

> > Another solution would be to provide an implementation of
> > atomic_io_modify() on arm64, though that would need the ACK from the
> > ARM64 maintainers.
> 
> It also sounds like a more modern solution might be to use syscon for
> the shared register, but perhaps I'm missing something about how the IP
> is set up so ICBW.

I think back when we implemented this, syscon/simple-mfd was
not available or widely used - I don't really remember. We could indeed
try to switch to a syscon based solution.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
