From: zwange@gmu.edu (Zhaohui Wang)
Date: Tue, 25 Jan 2011 23:29:13 -0500
Subject: [PATCH v2 01/11] msm: Add CPU queries
In-Reply-To: <1295985978.25496.35.camel@c-dwalke-linux.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-2-git-send-email-davidb@codeaurora.org>
	<1295914163.29639.77.camel@c-dwalke-linux.qualcomm.com>
	<8yak4htj0lb.fsf@huya.qualcomm.com>
	<1295915034.29639.78.camel@c-dwalke-linux.qualcomm.com>
	<8yay669hka5.fsf@huya.qualcomm.com>
	<1295976910.25496.1.camel@c-dwalke-linux.qualcomm.com>
	<8ya39ogg5dm.fsf@huya.qualcomm.com>
	<1295983549.25496.33.camel@c-dwalke-linux.qualcomm.com>
	<8yaei80epie.fsf@huya.qualcomm.com>
	<1295985978.25496.35.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <00e801cbbd11$96b3ca90$c41b5fb0$@gmu.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi all

Maybe it's not appropriate to cut in your discussion.
Can anyone explain what's the difference between qsd8X50 and msm8x60? No msm8x50, right?

Many thanks.


Best Regards
David Wange


-----Original Message-----
From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-owner at vger.kernel.org] On Behalf Of Daniel Walker
Sent: Tuesday, January 25, 2011 3:06 PM
To: David Brown
Cc: linux-arm-msm at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH v2 01/11] msm: Add CPU queries

On Tue, 2011-01-25 at 11:45 -0800, David Brown wrote:
> On Tue, Jan 25 2011, Daniel Walker wrote:
> 
> > On Tue, 2011-01-25 at 11:17 -0800, David Brown wrote:
> 
> > I suggesting we do it across the board because consistency is a good 
> > thing .. It also allows us to use 8x60 when 8660 and 8960 are 
> > actually similar .. You can't deny that 8960 is similar to 8660 
> > because your patches show some duplication due to it.
> 
> You're completely missing the point of these tests.  If _anything_ is 
> different, the macros need to be different.  I don't care if they're 
> similar, I need to know when they are different.  That is the point of 
> the macros.

I said you would have macros specifically for 8660 and 8960, so if you need to know when they're different then you have macro's to do that. 

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

--
To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in the body of a message to majordomo at vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
