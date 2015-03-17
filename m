From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Mar 2015 17:31:11 +0000
Subject: [PATCH 0/6] make memtest a generic kernel feature
In-Reply-To: <5508625F.6060600@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
 <20150317171822.GW8399@arm.com> <5508625F.6060600@arm.com>
Message-ID: <20150317173111.GA8399@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 05:20:31PM +0000, Vladimir Murzin wrote:
> On 17/03/15 17:18, Will Deacon wrote:
> > On Mon, Mar 09, 2015 at 10:27:04AM +0000, Vladimir Murzin wrote:
> >> Memtest is a simple feature which fills the memory with a given set of
> >> patterns and validates memory contents, if bad memory regions is detected it
> >> reserves them via memblock API. Since memblock API is widely used by other
> >> architectures this feature can be enabled outside of x86 world.
> >>
> >> This patch set promotes memtest to live under generic mm umbrella and enables
> >> memtest feature for arm/arm64.
> >>
> >> It was reported that this patch set was useful for tracking down an issue with
> >> some errant DMA on an arm64 platform.
> >>
> >> Since it touches x86 and mm bits it'd be great to get ACK/NAK for these bits.
> > 
> > Is your intention for akpm to merge this? I don't mind how it goes upstream,
> > but that seems like a sensible route to me.
> > 
> 
> It is already in -mm tree.

Cracking, I missed the memo somehow.

Will
