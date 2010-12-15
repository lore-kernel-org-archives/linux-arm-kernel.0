From: smuckle@codeaurora.org (Steve Muckle)
Date: Wed, 15 Dec 2010 09:53:43 -0800
Subject: [PATCH 2/7] msm: Physical offset for MSM8960
In-Reply-To: <20101215153837.GB15817@huya.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-3-git-send-email-stepanm@codeaurora.org>
	<4D08BFFC.3020103@ru.mvista.com>
	<20101215135508.GB8682@huya.qualcomm.com>
	<1292424054.13887.5.camel@m0nster>
	<20101215153837.GB15817@huya.qualcomm.com>
Message-ID: <4D0900A7.8070405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/10 07:38, David Brown wrote:
> There's not very much copying here, in fact there isn't very much to
> the 8960 support to begin with.  Despite the confusing names, 8960 is
> quite a bit different from 8[26]60.  I agree we would probably be best
> with different names, which might help make the difference clearer.

A couple more comments here...

Currently it is the case that there is a lot of similarity between 8960
and 8660, however the two are expected to diverge as 8960 support
matures. This may include things like the physical offset so IMO it is
better to leave this things as per-ARCH rather than combining them.

During some previous discussions on the naming situation, one idea which
was floated was renaming 8x60 to 8660, which would help clarify the
difference from 8960. The only issue with that is that 8260, which is
for purposes of the kernel the same as 8660, would be left out and
probably just have to be mentioned in the Kconfig help text for 8660.

thanks,
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
