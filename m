From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 1 Aug 2014 22:52:56 +0530
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140731132223.GK30282@n2100.arm.linux.org.uk>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <20140731132223.GK30282@n2100.arm.linux.org.uk>
Message-ID: <20140801172256.GH8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 02:22:23PM +0100, Russell King - ARM Linux wrote:
> DMA engine has lacked a lot of infrastructure for common patterns in
> drivers; some of that is solved by my efforts with the virt_dma.c
> support, and also various cleanups to existing drivers, but it's not
> easy to fix this problem after drivers have been merged.
I think list management is something that needs fix. I see lots of time and
energy being spent by drivers in this.
I will plan for this in near future to move descriptor and list management
to the framework. That should help drivers get cleaned up a bit more

-- 
~Vinod
