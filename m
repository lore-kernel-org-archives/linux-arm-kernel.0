From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Jan 2015 22:51:13 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <20150110223624.74d21d47@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2596012.A9D9qEFWVV@wuerfel> <20150110223624.74d21d47@free-electrons.com>
Message-ID: <1530292.P7jYsdBZGH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 January 2015 22:36:24 Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Sat, 10 Jan 2015 21:40:07 +0100, Arnd Bergmann wrote:
> 
> > Yes, but it may be better to stage this by first putting a patch
> > into stable that completely disables the broken coherent mapping,
> > and following up with another patch to bring the cohernet behavior
> > in sync with mainline once we are reasonably sure it's good.
> 
> Fine with me. I'll submit such patches next week.

Ok.

> Though for the next
> merge window, I'd like the proposed automatic I/O synchronization
> barriers to be merged, so that we progressively make progress towards
> the solution.

Yes, definitely. I wouldn't mind taking them for 3.19 even if all mvebu
maintainers want that.

	Arnd
