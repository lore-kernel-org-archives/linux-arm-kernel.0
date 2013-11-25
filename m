From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 25 Nov 2013 15:08:04 -0700
Subject: [PATCH 3/4] ARM: mvebu: NETGEAR ReadyNAS 104 .dts file cleanup
In-Reply-To: <87vbzgf8av.fsf@natisbad.org>
References: <cover.1385148929.git.arno@natisbad.org>
 <bd899cfc2b0b3d22a7442d76b3901ca81ca86f11.1385148929.git.arno@natisbad.org>
 <20131122213610.GC30358@obsidianresearch.com>
 <878uwg5b6e.fsf@natisbad.org>
 <20131125194117.GA5413@obsidianresearch.com>
 <87vbzgf8av.fsf@natisbad.org>
Message-ID: <20131125220804.GA11260@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:03:36PM +0100, Arnaud Ebalard wrote:

> > Also, check if it is actually an S varient or not, they have the same
> > phy-id.. ;)
> 
> On the chip, I have 88E1318-NNB2 (PNN1230_3JW 1209 A0P TW). I will see
> if I can find more info.

That is the standard varient - I expect the S version is rare. NNB2
indicates the package option. The rest is the lot code.

Jason
