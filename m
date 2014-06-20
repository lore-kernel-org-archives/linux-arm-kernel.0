From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jun 2014 09:39:47 +0100
Subject: [PATCH] arm64: add the ability to hook the fault code
In-Reply-To: <9034CBD80F070943B59700D7F8149ED90182148D02@SC-VEXCH4.marvell.com>
References: <1403175296-25181-1-git-send-email-zhangwm@marvell.com>
 <20140620082556.GD25104@arm.com>
 <9034CBD80F070943B59700D7F8149ED90182148D02@SC-VEXCH4.marvell.com>
Message-ID: <20140620083946.GF25104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 09:33:59AM +0100, Neil Zhang wrote:
> 
> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon at arm.com]
> > Sent: 2014?6?20? 16:26
> > To: Neil Zhang
> > Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org;
> > linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH] arm64: add the ability to hook the fault code
> > 
> > On Thu, Jun 19, 2014 at 11:54:56AM +0100, Neil Zhang wrote:
> > > Add the ability to hook the fault code for future use.
> > 
> > Do you have a user for this in the kernel tree? I'd rather add the hook with
> > the first user, if it doesn't exist already.
> > 
> 
> Marvell Soc has a feature to use the external abort.
> I didn't submit it since it's a private feature.

In which case, let's wait until we have a user of this in the mainline tree.

Will
