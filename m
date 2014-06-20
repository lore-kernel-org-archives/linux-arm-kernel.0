From: zhangwm@marvell.com (Neil Zhang)
Date: Fri, 20 Jun 2014 01:33:59 -0700
Subject: [PATCH] arm64: add the ability to hook the fault code
In-Reply-To: <20140620082556.GD25104@arm.com>
References: <1403175296-25181-1-git-send-email-zhangwm@marvell.com>
 <20140620082556.GD25104@arm.com>
Message-ID: <9034CBD80F070943B59700D7F8149ED90182148D02@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: 2014?6?20? 16:26
> To: Neil Zhang
> Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] arm64: add the ability to hook the fault code
> 
> On Thu, Jun 19, 2014 at 11:54:56AM +0100, Neil Zhang wrote:
> > Add the ability to hook the fault code for future use.
> 
> Do you have a user for this in the kernel tree? I'd rather add the hook with
> the first user, if it doesn't exist already.
> 

Marvell Soc has a feature to use the external abort.
I didn't submit it since it's a private feature.

> Will

Best Regards,
Neil Zhang
