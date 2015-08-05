From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Aug 2015 13:53:35 +0300
Subject: [PATCH v3 0/5] iommu/arm-smmu: add support for non-pci devices
In-Reply-To: <20150805104524.GD6092@arm.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
 <2351780.FdaR8mZqKs@avalon> <20150805104524.GD6092@arm.com>
Message-ID: <2055191.Tg39UMkbi6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wednesday 05 August 2015 11:45:24 Will Deacon wrote:
> On Tue, Aug 04, 2015 at 11:50:45PM +0100, Laurent Pinchart wrote:
> > On Tuesday 28 July 2015 13:48:47 Will Deacon wrote:
> >> On Tue, Jul 21, 2015 at 11:30:07AM +0100, Robin Murphy wrote:
> >>> On 21/07/15 08:30, Zhen Lei wrote:
> >>>> Changelog:
> >>>> v2 -> v3:
> >>>> 1. add support for pci device hotplug, which missed in patch v2.
> >>>> 2. only support #iommu-cells = <1>, add corresponding description in
> >>>> arm,smmu-v3.txt. 3. add function find_smmu_by_device which extracted
> >>>> from find_smmu_by_node, to resolve> >
> >>>> 
> >>>>     the problem mentioned by Robin Murphy in [PATCH v2 7/9].
> >>>>     Additionally:
> >>>>     +    platform_set_drvdata(pdev, smmu);       //Patch v2
> >>>>     +	dev->archdata.iommu = smmu;             //Patch v3, dev =
> >>>>     &pdev->dev
> >>> 
> >>> I didn't give any Reviewed-by tags, much less to revised patches that
> >>> I've not even looked at yet; please see section 13 of
> >>> Documentation/SubmittingPatches for what the Reviewed-by tag means.
> >> 
> >> That said, it would be great if you could review the patches anyway ;)
> >> 
> >> Also, it looks like this is all based on Laurent's IOMMU probe deferral
> >> series which hasn't seen any movement for a while.
> >> 
> >> Laurent: are you planning to repost that, or is it worth us picking up
> >> the original version and bashing it into shape ourselves?
> > 
> > I'd really appreciate if you could take it where I left it and get into
> > shape for upstream. I have no time to work on IOMMU at the moment I'm
> > afraid :-(
>
> No problem at all. It will probably be Robin doing most of the hacking,
> since he's the platform_device guy and I'm the PCI guy in the office at
> the moment :)
> 
> I think he's also currently got a rebased version of your series with
> some changes on top, so stay tuned.

Great ! As they say here, paljon kiitoksia (yes, Finnish can be used on 
mailing lists for other purposes than cursing ;-)).

> > I'll try to review patches though.
> 
> That would certainly be appreciated, cheers!

-- 
Regards,

Laurent Pinchart
