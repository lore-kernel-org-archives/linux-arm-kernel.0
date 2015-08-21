From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Aug 2015 14:21:46 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix holding lock while calling tx
 callback in cleanup path
In-Reply-To: <CAFd313wEAWjzJa82R1ujh3vyMasDvicQ4nZHq1qqZ5y7D4ixzQ@mail.gmail.com>
References: <1440066656-15516-1-git-send-email-rsahu@apm.com>
 <20150821083946.GO13546@localhost>
 <CAFd313wEAWjzJa82R1ujh3vyMasDvicQ4nZHq1qqZ5y7D4ixzQ@mail.gmail.com>
Message-ID: <20150821085146.GP13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 02:15:08PM +0530, Rameshwar Sahu wrote:
> Hi Vinod,
> 
> On Fri, Aug 21, 2015 at 2:09 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Thu, Aug 20, 2015 at 04:00:56PM +0530, Rameshwar Prasad Sahu wrote:
> >> This patch fixes the an locking issue where client callback performs
> >                 ^^^^^^^^^^^^
> > ??
> >
> >> further submission.
> > Do you men you are preventing that or fixing for this to be allowed?
> 
> Fixing lock to allow client to submit further request in there
> callback routine if they would like.

Okay please fix the changelog to make it clear :)

-- 
~Vinod
