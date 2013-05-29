From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 15:11:37 +0200
Subject: [PATCH 3/3] ARM PJ4B: Add support for errata 4611
In-Reply-To: <51A5FB26.4090000@free-electrons.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <20130529112207.GG13095@mudshark.cambridge.arm.com>
 <51A5FB26.4090000@free-electrons.com>
Message-ID: <4523769.Zp7B72tmfz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013 14:57:10 Gregory CLEMENT wrote:
> 
> For the first point, unfortunately it is not possible as they are
> errata for different CPUs. If finally the 2 last patches won't be
> merged in 3.10, then I will add a new patch before them, to introduce
> the PJ4B-MP which is the CPU used by the Armada XP whereas the
> Armada 370 uses the PJ4B.
> 
> For the second point and the other CPU specific questions you raised
> in the other emails, I am waiting for answer from Marvell engineers.

I've been confused by the various CPU types before. If you have
any information that's not yet in the excellent
Documentation/arm/Marvell/README file that Thomas added, could you
put it in there?

In particular, I'd like to understand what variants of PJ4 there
are, and maybe you can list their cpuid part numbers.

	Arnd
