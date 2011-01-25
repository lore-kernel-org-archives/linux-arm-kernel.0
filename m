From: davidb@codeaurora.org (David Brown)
Date: Tue, 25 Jan 2011 11:45:29 -0800
Subject: [PATCH v2 01/11] msm: Add CPU queries
In-Reply-To: <1295983549.25496.33.camel@c-dwalke-linux.qualcomm.com> (Daniel
	Walker's message of "Tue, 25 Jan 2011 11:25:49 -0800")
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
Message-ID: <8yaei80epie.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25 2011, Daniel Walker wrote:

> On Tue, 2011-01-25 at 11:17 -0800, David Brown wrote:

> I suggesting we do it across the board because consistency is a good
> thing .. It also allows us to use 8x60 when 8660 and 8960 are actually
> similar .. You can't deny that 8960 is similar to 8660 because your
> patches show some duplication due to it.

You're completely missing the point of these tests.  If _anything_ is
different, the macros need to be different.  I don't care if they're
similar, I need to know when they are different.  That is the point of
the macros.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
