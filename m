From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Nov 2016 09:02:06 +0530
Subject: [PATCH v10 01/11] remoteproc: st_slim_rproc: add a slimcore
 rproc driver
In-Reply-To: <20161114114216.GA8986@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
 <1476783556-2501-2-git-send-email-peter.griffin@linaro.org>
 <20161103213703.GA15449@tuxbot>
 <20161107135735.GA27280@griffinp-ThinkPad-X1-Carbon-2nd>
 <20161114051854.GW3000@localhost>
 <20161114114216.GA8986@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20161116033206.GX3000@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 11:42:16AM +0000, Peter Griffin wrote:
> Hi Vinod,
> 
> On Mon, 14 Nov 2016, Vinod Koul wrote:
> 
> > On Mon, Nov 07, 2016 at 01:57:35PM +0000, Peter Griffin wrote:
> > > > 
> > > > As you now make changes to the entire remoteproc Kconfig file, rather
> > > > than simply add a Kconfig symbol we can't bring this in via Vinod's tree
> > > > without providing Linus with a messy merge conflict.
> > > > 
> > > > So the remoteproc parts now has to go through my tree.
> > > 
> > > OK, I think the best approach is for Vinod to create an immutable
> > > branch with the entire fdma series on, and then both of you merge that branch into
> > > your respective trees.
> > 
> > my topic/st_fdma is immutable branch. You cna merge it, if you need a signed
> > tag, please do let me know
> 
> OK.
> 
> > 
> > > 
> > > That way there won't be any conflicts and you can both accept further changes
> > > for v4.9 release. Trying to take half the series via rproc, and half via dma trees won't work
> > > because they have dependencies on each other.
> > > 
> > > I will send a v11 series in a moment which includes the feedback in this email
> > > and also include the additional fixes which Vinod has applied since the driver
> > > has been in linux-next.
> > 
> > WHY.. Stuff is already merged twice!
> 
> When the feedback is "there is an unrelated change in this patch", the only way
> you can fix that is by having a new version of the patch.

It can be reverted and clean patch applied..

-- 
~Vinod
