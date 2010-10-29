From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Oct 2010 15:32:36 -0700
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <alpine.LFD.2.00.1010291814090.11553@xanadu.home>
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
Message-ID: <1288391556.6631.23.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-29 at 18:17 -0400, Nicolas Pitre wrote:

> Could you at least comment the patch I posted for you?

I didn't see anything wrong with it, not from an MSM perspective.

> If this fixes the issue then Russell might just merge it now.  In any 
> case, that kind of fix may perfectly well be merged during the -rc 
> period since that's exactly what the -rc period is all about: fixing 
> those kind of fallouts after the big merge.

I'd like to have MSM building before -rc1 , that's why I was suggesting
I go with my original revert then we would fix this issue during the -rc
cycle.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
