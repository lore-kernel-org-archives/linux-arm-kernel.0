From: davidb@codeaurora.org (David Brown)
Date: Tue, 25 Oct 2011 14:34:48 -0700
Subject: [PATCHv2] msm: boards: Fix fallout from removal of machine_desc
	in fixup
In-Reply-To: <20111025210610.GA26579@n2100.arm.linux.org.uk>
References: <1319560519-18899-1-git-send-email-sboyd@codeaurora.org>
	<20111025205053.GA15649@huya.qualcomm.com>
	<20111025210610.GA26579@n2100.arm.linux.org.uk>
Message-ID: <20111025213448.GA16295@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 10:06:10PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 25, 2011 at 01:50:53PM -0700, David Brown wrote:
> > On Tue, Oct 25, 2011 at 09:35:19AM -0700, Stephen Boyd wrote:
> > > After 0744a3ee (ARM: platform fixups: remove mdesc argument to
> > > fixup function, 2010-12-20) the fixup functions introduced in
> > > 9e775ad (ARM: 7012/1: Set proper TEXT_OFFSET for newer MSMs,
> > > 2011-08-12) cause warnings like:
> > > 
> > > arch/arm/mach-msm/board-msm8x60.c:85: warning: initialization
> > > from incompatible pointer type
> > > 
> > > Fix them by removing the machine_desc argument from the fixup
> > > functions.
> > > 
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > Yes, these got missed among the merges.
> > 
> > Acked-by: David Brown <davidb@codeaurora.org>
> > 
> > Russell, would you prefer this to go through your tracker, or for me
> > to push this to Arnd?
> 
> Either is fine.

I can pull it, then, since it is entirely inside of MSM.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
