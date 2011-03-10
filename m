From: davidb@codeaurora.org (David Brown)
Date: Thu, 10 Mar 2011 12:37:59 -0800
Subject: [PATCH] msm: gpio-v2: Add missing BIT field macros for interrupt
	control
In-Reply-To: <1299522832-31233-1-git-send-email-rvaswani@codeaurora.org>
	(Rohit Vaswani's message of "Mon, 7 Mar 2011 10:33:52 -0800")
References: <1299522832-31233-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <8yaoc5i90ew.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07 2011, Rohit Vaswani wrote:

> The gpio-v2 file was missing the BIT field macros causing incorrect
> values to be written at incorrect offsets within the TLMM block registers.
> These registers are used for masking/unmasking interrupts and configuring them
> This change fixes that problem.
>
> Change-Id: Ib538a2d09bca039b058627ddc309a7faaaf6bc8d
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>

Please remember to remove these Change-Id lines from patches before
sending them out.  I'll remove them from these patches, since there
don't seem to be any other comments.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
