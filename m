From: joe@perches.com (Joe Perches)
Date: Wed, 02 Apr 2014 14:44:18 -0700
Subject: [PATCH 1/1] AArch64: TCR_TG1_64K incorrectly sets TCR_EL1 bits
 [31:30]
In-Reply-To: <20140402170747.GC24018@arm.com>
References: <CAHWCVW+cH6MwhQj-JGWN63AqseFYuDPoftv+zGJU8UDfAgueEQ@mail.gmail.com>
 <20140402123844.GE31892@arm.com> <20140402170747.GC24018@arm.com>
Message-ID: <1396475058.32040.10.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-02 at 18:07 +0100, Catalin Marinas wrote:
> On Wed, Apr 02, 2014 at 01:38:44PM +0100, Catalin Marinas wrote:
> > On Wed, Apr 02, 2014 at 05:00:38AM +0100, Joe Sylve wrote:
> > > Section D7.2.83 TCR_EL1, Translation Control Register (EL1) of the
> > > latest ARM Architecture Reference Manual, ARMv8, for ARMv8-A states
> > > that TCR_EL1 TG1 (bits [31:30]) should be set to 11 for a 64KB
> > > TTBR1_EL1 granule size. The mainline 3.14 kernel incorrectly sets
> > > those bits to 01 (which is a 16KB granule size).

trivia:

I think the subject title should be arm64
