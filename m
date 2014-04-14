From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Apr 2014 17:58:58 +0100
Subject: [PATCH 0/2] ARM SMMU fixes
In-Reply-To: <53440057.6020703@arm.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2243447.NTvYmPQWSB@avalon> <93132940.WGeAzvU3EP@avalon>
 <53440057.6020703@arm.com>
Message-ID: <20140414165858.GI12916@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 02:57:43PM +0100, Marc Zyngier wrote:
> On 08/04/14 14:41, Laurent Pinchart wrote:
> > I've obviously forgotten that Will was away for a month. CC'ing Marc Zyngier.
> > 
> > On Thursday 03 April 2014 01:52:55 Laurent Pinchart wrote:
> >> On Friday 28 February 2014 16:37:08 Laurent Pinchart wrote:
> >>> Hello Will,
> >>>
> >>> I've studied your arm-smmu driver as a base to write a Renesas IOMMU
> >>> driver and found two small issues. Here are patches to fix them. Please
> >>> bear with me if my understanding was incorrect and the patches wrong :-)
> >>>
> >>> Laurent Pinchart (2):
> >>>   iommu/arm-smmu: Replace list walk with platform driver data
> >>>   iommu/arm-smmu: Return 0 on unmap failure
> >>>  
> >>>  drivers/iommu/arm-smmu.c | 17 +++++------------
> >>>  1 file changed, 5 insertions(+), 12 deletions(-)
> >>
> >> Do you plan to take these patches (or at least patch 2/2) in your tree ? I
> >> can send a pull request to Joerg if you give me your acked-by.
> > 
> > Marc, would you like to handle this, or would you prefer to wait until Will 
> > comes back ?
> 
> Hi Laurent,
> 
> Yup, I'll have a look and stash them in a temp tree. Given that Will
> will be back in about a week, he will have the final say.

I've already got the fix queued ("Return 0 on unmap failure") and plan to
send it to Joerg this week. I think the other patch doesn't really add
anything to the driver :)

Will
