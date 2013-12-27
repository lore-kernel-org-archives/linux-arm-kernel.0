From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Dec 2013 12:48:54 -0500
Subject: [PATCH 0/3] dma: mv_xor: spinlock related improvements
In-Reply-To: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131227174854.GV19878@titan.lakedaemon.net>
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
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   dma: mv_xor: take channel spinlock in mv_xor_status()
>   dma: mv_xor: use __mv_xor_slot_cleanup() in
>     mv_xor_free_chan_resources()
>   dma: mv_xor: rename __mv_xor_slot_cleanup() to mv_xor_slot_cleanup()
> 
>  drivers/dma/mv_xor.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)

for the whole series:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
