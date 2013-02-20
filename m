From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 20 Feb 2013 15:28:18 +0530
Subject: [PATCH 0/4] dw_dmac: introduce generic DMA binding for DT
In-Reply-To: <201302200950.26182.arnd@arndb.de>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
 <20130220080348.GF23302@intel.com>
 <201302200950.26182.arnd@arndb.de>
Message-ID: <20130220095818.GI23302@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 09:50:25AM +0000, Arnd Bergmann wrote:
> On Wednesday 20 February 2013, Vinod Koul wrote:
> > Since there is still churn, would it make sense if I just revert the SPEAr13xx
> > patch (your first patch) and send a pull request to Linus.
> > Since there are no users and not much testing has been done, I think we can push
> > these to 3.10 via arm-soc/slave-dma tree.
> > 
> > Gives more testing and usage will go along as well.
> > Since merge window is open, I would like my pull to go soonish and not churn the
> > tree much.
> 
> Reverting the SPEAr13xx would definitely help, yes. The reason why I'd also like
> to see the second patch get merged is so that we can do the SPEAr changes in 3.10
> without having an interdependency between the trees. I tried very hard to
> make the patch have a minimal impact on the non-DT code path to avoid regressions.
Ok, i have applied your revert patch. Will send the PULL to linus by friday.

> Maybe you can send your tree now with just the revert applied, and then send the
> other one separately next week along with any bug fixes that may have accumulated
> by then?
And then makes sense to send second PULL with fixes accumulated and the second
patch, so that 3.10 is easier for all.  think we can compact() patch is second
request as well

--
~Vinod
