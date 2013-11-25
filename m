From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 25 Nov 2013 12:41:17 -0700
Subject: [PATCH 3/4] ARM: mvebu: NETGEAR ReadyNAS 104 .dts file cleanup
In-Reply-To: <878uwg5b6e.fsf@natisbad.org>
References: <cover.1385148929.git.arno@natisbad.org>
 <bd899cfc2b0b3d22a7442d76b3901ca81ca86f11.1385148929.git.arno@natisbad.org>
 <20131122213610.GC30358@obsidianresearch.com>
 <878uwg5b6e.fsf@natisbad.org>
Message-ID: <20131125194117.GA5413@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 11:22:33PM +0100, Arnaud Ebalard wrote:

> and also the fact that *in my case* the kernel does its job
> auto-detecting the PHY, I now also wonder how the kernel can
> use that info and what I get by adding the compatible string.

I think the main rational was to document what chip the phy is to
people who don't have the hardware...

You probably shouldn't delay your patch on this issue, document the
phy chip model in a comment?

Also, check if it is actually an S varient or not, they have the same
phy-id.. ;)

Jason
