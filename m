From: davidb@codeaurora.org (David Brown)
Date: Wed, 10 Aug 2011 08:51:30 -0700
Subject: [RFC PATCH 5/8] ARM: msm: convert logical CPU numbers to
	physical numbers
In-Reply-To: <20110810084218.GA10121@e102144-lin.cambridge.arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
	<1312926162-22469-6-git-send-email-will.deacon@arm.com>
	<20110809222604.GA15160@huya.qualcomm.com>
	<20110810084218.GA10121@e102144-lin.cambridge.arm.com>
Message-ID: <20110810155130.GB4059@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 09:42:19AM +0100, Will Deacon wrote:
> On Tue, Aug 09, 2011 at 11:26:04PM +0100, David Brown wrote:
> > On Tue, Aug 09, 2011 at 10:42:39PM +0100, Will Deacon wrote:
> > > This patch uses the new cpu_logical_map() macro for converting logical
> > > CPU numbers into physical numbers when dealing with the pen_release
> > > variable in the SMP boot and CPU hotplug paths.
> > > 
> > > Cc: David Brown <davidb@codeaurora.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 
> > For MSM8660:
> > 
> > Tested-by: David Brown <davidb@codeaurora.org>
> > Acked-by: David Brown <davidb@codeaurora.org>
> 
> Thanks David!
> 
> Curious: did you try booting with a CPU other than physical CPU 0 or is
> that not possible on your platform?

I haven't.  I'll look into whether that is possible.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
