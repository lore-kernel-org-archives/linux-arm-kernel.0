From: attila@kinali.ch (Attila Kinali)
Date: Mon, 16 Jul 2012 11:19:25 +0200
Subject: [PATCH] dma: mxs-dma: Export missing symbols from mxs-dma.c
In-Reply-To: <1342420246.1726.43.camel@vkoul-udesk3>
References: <20120706122141.GE22133@S2101-09.ap.freescale.net>
 <1341579200-13268-1-git-send-email-attila@kinali.ch>
 <1342420246.1726.43.camel@vkoul-udesk3>
Message-ID: <20120716111925.f5e4ce848cce4136948457a4@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jul 2012 12:00:46 +0530
Vinod Koul <vinod.koul@linux.intel.com> wrote:

> On Fri, 2012-07-06 at 14:53 +0200, Attila Kinali wrote:
> > mxs-dma.c provides two functions mxs_dma_is_apbh and mxs_dma_is_apbx
> > which are used at least in mxs-mmc.c. Building mxs-mmc as module
> > fails due to those two symbols not being exported.
> Applied thanks.

Thanks a lot!

> Please DO NOT forget to CC maintainers, the patch can get lost
> otherwise. get_maintainer.pl is your friend, use it!

Oki, i'll keep that in mind.

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
