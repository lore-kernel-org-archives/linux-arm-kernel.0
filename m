From: davidb@codeaurora.org (David Brown)
Date: Fri, 5 Nov 2010 14:31:38 -0700
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <1288393638.6631.65.camel@m0nster>
References: <alpine.LFD.2.00.1010281422190.3227@xanadu.home>
	<20101028182851.GI3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010281441540.3227@xanadu.home>
	<20101028184627.GK3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010282226460.5029@xanadu.home>
	<1288387033.6631.13.camel@m0nster>
	<alpine.LFD.2.00.1010291814090.11553@xanadu.home>
	<1288391556.6631.23.camel@m0nster>
	<alpine.LFD.2.00.1010291849030.11553@xanadu.home>
	<1288393638.6631.65.camel@m0nster>
Message-ID: <20101105213138.GA13085@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 29, 2010 at 04:07:18PM -0700, Daniel Walker wrote:

> The build issue is a little more dire I think, I never suggested my
> revert fixed anything but the build issue (which was the point) .. It
> was just suppose to bring back what was wrongfully removed.

A compile error for an invalid configuration is better than a crash.

David
