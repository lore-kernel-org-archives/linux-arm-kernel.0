From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 14:39:26 +0000
Subject: [PATCH v9 3/6] arm64/arm, numa, dt: adding numa dt binding
 implementation for arm64 platforms.
In-Reply-To: <20160126203603.GC17600@localhost>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-4-git-send-email-gkulkarni@caviumnetworks.com>
 <20160126203603.GC17600@localhost>
Message-ID: <20160128143925.GC775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 02:36:04PM -0600, Bjorn Helgaas wrote:
> Subject is "arm64/arm, numa, dt: adding ..."  What is the significance
> of the "arm" part?  The other patches only mention "arm64".
> 
> General comment: the code below has little, if anything, that is
> actually arm64-specific.  Maybe this is the first DT-based NUMA
> platform?  I don't see other similar code for other arches, so maybe
> it's too early to try to generalize it, but we should try to avoid
> adding duplicates of this code if/when other arches do show up.

Having it in the core code would allow us to share it with arch/arm/
fairly straightforwardly.

Will
