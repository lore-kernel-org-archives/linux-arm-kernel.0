From: davidb@codeaurora.org (David Brown)
Date: Fri, 15 Apr 2011 11:27:41 -0700
Subject: [PATCH 4/6] ARM: msm: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1302633340-4795-5-git-send-email-will.deacon@arm.com> (Will
	Deacon's message of "Tue, 12 Apr 2011 19:35:38 +0100")
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-5-git-send-email-will.deacon@arm.com>
Message-ID: <8yazknr1iaq.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12 2011, Will Deacon wrote:

> This patch updates the MSM gpio chained IRQ handler to use the chained
> IRQ enter/exit functions in order to function correctly on primary
> controllers with different methods of flow control.
>
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I'm okay acking this as long as Abhijeet is ok with it.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
