From: davidb@codeaurora.org (David Brown)
Date: Fri, 29 Jul 2011 07:01:27 -0700
Subject: [PATCH 2/2] ARM: msm: Remove PLAT_PHYS_OFFSETS from MSM targets
In-Reply-To: <alpine.LFD.2.00.1107290841300.12766@xanadu.home>
References: <1311794355-26988-2-git-send-email-sboyd@codeaurora.org>
	<1311884291-5409-1-git-send-email-davidb@codeaurora.org>
	<1311884291-5409-2-git-send-email-davidb@codeaurora.org>
	<20110729103239.GC25640@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107290841300.12766@xanadu.home>
Message-ID: <20110729140127.GA17137@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 08:42:15AM -0400, Nicolas Pitre wrote:
> On Fri, 29 Jul 2011, Russell King - ARM Linux wrote:
> 
> > On Thu, Jul 28, 2011 at 01:18:11PM -0700, David Brown wrote:
> > > Now that MSM can boot with the phys offset patching, eliminate the
> > > definitions of the phys offsets, and instead select
> > > ARM_PATCH_PHYS_VIRT.
> > 
> > I think it may be better to remove the EXPERIMENTAL status of
> > ARM_PATCH_PHYS_VIRT, and make the option default to 'y' now, so that
> > we start building all kernels with this enabled.  If people don't
> > want it (and know what they're doing) they can disable it manually
> > (maybe make the option only appear for EXPERT).
> 
> One of my jumbo patch series is doing that.
> 
> > Lets see about that after this merge window is over.

In that case, I'll resend just the second of my patches after this
series.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
