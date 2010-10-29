From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Oct 2010 15:21:22 -0700
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <20101029221437.GA31224@n2100.arm.linux.org.uk>
References: <20101028163518.GG3122@n2100.arm.linux.org.uk>
	<1288284066.2683.9.camel@c-dwalke-linux.qualcomm.com>
	<20101028174653.GH3122@n2100.arm.linux.org.uk>
	<1288288824.2683.24.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010281422190.3227@xanadu.home>
	<20101028182851.GI3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010281441540.3227@xanadu.home>
	<20101028184627.GK3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010282226460.5029@xanadu.home>
	<1288387033.6631.13.camel@m0nster>
	<20101029221437.GA31224@n2100.arm.linux.org.uk>
Message-ID: <1288390882.6631.16.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-29 at 23:14 +0100, Russell King - ARM Linux wrote:

> Your original patch is unsuitable as it leaves the values uninitialized.
> 

All I'm really concerned about is fixing the build issue during this
merge window. But I'll send another patch with your suggestions added.

Daniel
-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
