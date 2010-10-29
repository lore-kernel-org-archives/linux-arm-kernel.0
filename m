From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Oct 2010 16:07:18 -0700
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <alpine.LFD.2.00.1010291849030.11553@xanadu.home>
References: <20101027221428.GB28391@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010272227380.31220@xanadu.home>
	<1288283413.2683.2.camel@c-dwalke-linux.qualcomm.com>
	<20101028163518.GG3122@n2100.arm.linux.org.uk>
	<1288284066.2683.9.camel@c-dwalke-linux.qualcomm.com>
	<20101028174653.GH3122@n2100.arm.linux.org.uk>
	<1288288824.2683.24.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010281422190.3227@xanadu.home>
	<20101028182851.GI3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010281441540.3227@xanadu.home>
	<20101028184627.GK3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010282226460.5029@xanadu.home>
	<1288387033.6631.13.camel@m0nster>
	<alpine.LFD.2.00.1010291814090.11553@xanadu.home>
	<1288391556.6631.23.camel@m0nster>
	<alpine.LFD.2.00.1010291849030.11553@xanadu.home>
Message-ID: <1288393638.6631.65.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-29 at 18:53 -0400, Nicolas Pitre wrote:
> On Fri, 29 Oct 2010, Daniel Walker wrote:
> 
> > On Fri, 2010-10-29 at 18:17 -0400, Nicolas Pitre wrote:
> > 
> > > Could you at least comment the patch I posted for you?
> > 
> > I didn't see anything wrong with it, not from an MSM perspective.
> 
> So now you have two possibilities: my patch, or Russell's suggestions.  
> Personally I find my patch is slightly better in the sense that it 
> doesn't make use of a magic 0xfff00000 value with no obvious semantic.  
> But you have the choice.

Russell's because I think I can get that in right now, which is all I
care about.

> > I'd like to have MSM building before -rc1 , that's why I was suggesting
> > I go with my original revert then we would fix this issue during the -rc
> > cycle.
> 
> y
> Your "fix" is just as broken as the current compilation problem.  Sure 
> with your revert you may compile a kernel, but that kernel may as well 
> crash at run time instead.

The build issue is a little more dire I think, I never suggested my
revert fixed anything but the build issue (which was the point) .. It
was just suppose to bring back what was wrongfully removed.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
