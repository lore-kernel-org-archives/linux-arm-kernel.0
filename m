From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Feb 2011 16:47:00 +0000
Subject: [PATCH 0/4] ARM: Basic Xilinx Support
In-Reply-To: <eab51420-2be9-429a-8c59-76b3206bc15e@VA3EHSMHS033.ehs.local>
References: <eab51420-2be9-429a-8c59-76b3206bc15e@VA3EHSMHS033.ehs.local>
Message-ID: <20110205164700.GF29411@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 09:08:40AM -0700, John Linn wrote:
> This patch series adds very basic support for the Xilinx ARM platform.
> The entire patch set must be used. I only broke it up into logical 
> pieces to make the review easier (I hope). 

It's actually a question of patch ordering - if patch 1 comes at the
end, the other patches are just putting the files in place.  Until
patch 1 is in place, none of it will be built.

If it's necessary to split stuff in this manner, it's quite usual for
the configuration/makefile additions to come last in the series to
avoid build errors half way through.
