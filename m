From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 27 Dec 2013 12:54:36 -0300
Subject: [PATCH 0/3] dma: mv_xor: spinlock related improvements
In-Reply-To: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131227155435.GC15734@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 27, 2013 at 12:38:31PM +0100, Thomas Petazzoni wrote:
> Vinod, Dan,
> 
> Here are three patches that make improvements to the spinlock handling
> of the mv_xor driver. The first patch fixes a lock/release of the
> channel spinlock in mv_xor_status(), and the next two patches make
> followup code improvements/refactoring.
> 
> Ezequiel, it would be good to have your review on these patches, since
> I know you've spent some time lately doing mv_xor stuff.
> 

Spinlocks aren't the easiest thing to get right, and this driver is not
particularly simple. Anyway, to the best of my knowledge:

Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
