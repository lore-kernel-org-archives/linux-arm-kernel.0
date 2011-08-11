From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Aug 2011 15:24:38 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <CACRpkdZs=PuFNfHTiviF-vXaz2_-w8g-ZsMw6_mhozbZ8a3r7Q@mail.gmail.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdZs=PuFNfHTiviF-vXaz2_-w8g-ZsMw6_mhozbZ8a3r7Q@mail.gmail.com>
Message-ID: <20110811142438.GA5154@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Aug 11, 2011 at 03:05:01PM +0100, Linus Walleij wrote:
> On Wed, Aug 10, 2011 at 5:24 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > [ ? ?0.000000] CPU: found DTCM0 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved DTCM0 4k to fffe8000, enabled
> > [ ? ?0.000000] CPU: found DTCM1 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved DTCM1 4k to fffe9000, enabled
> > [ ? ?0.000000] CPU: found ITCM0 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved ITCM0 4k to fffe0000, enabled
> > [ ? ?0.000000] CPU: found ITCM1 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved ITCM1 4k to fffe1000, enabled
> 
> Just hijacking the thread: at one time I think I saw some ARM
> high-level schematic of a mpcore where the ARM cores actually had
> TCM in them.

Hmm, that doesn't sound right. The 11MPCore doesn't have TCMs.

> I actually spent some time adding multicore TCM support until
> I realized that the PB11MPcore actually didn't have TCM.
> So I just dropped that stuff.
> 
> But to be sure, is there a platform like that, multicore, with
> per-processor TCM?

It's a feature of the CPU rather than the platform and the 11MPCore doesn't
have TCMs.

Hope that clears things up,

Will
