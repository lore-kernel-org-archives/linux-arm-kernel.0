From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 05 Jul 2011 12:15:41 -0700
Subject: [stable] [PATCH v2] msm: timer: compensate for timer shift in
	msm_read_timer_count
In-Reply-To: <20110621162427.GA28836@kroah.com>
References: <1308344138-2862-1-git-send-email-johlstei@codeaurora.org>	<20110620215922.GA21909@kroah.com>	<8ya7h8gozhn.fsf@huya.qualcomm.com>
	<20110621162427.GA28836@kroah.com>
Message-ID: <4E1362DD.7030001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg KH wrote:
> On Mon, Jun 20, 2011 at 04:27:16PM -0700, David Brown wrote:
>> I don't think this patch was intended for stable in the first place.
>> Jeff, this is a fix for 3.0-rcx, right?
> 
> Then why was it sent to stable at kernel.org?
> 
> confused,
> 
> greg k-h
> 

Sorry, this was indeed intended for stable. I will include the Cc: tag
in future patches stable. However, since this was already picked up in
Linus's tree, how should I proceed to get it into stable?

Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
