From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 24 Jun 2013 10:39:09 -0400
Subject: [PATCH] ARM: Add support for LPAE style CONTEXTIDR
In-Reply-To: <20130624140424.GA24861@mudshark.cambridge.arm.com>
References: <1372080405-13365-1-git-send-email-cov@codeaurora.org>
 <20130624140424.GA24861@mudshark.cambridge.arm.com>
Message-ID: <51C85A0D.3070400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 06/24/2013 10:04 AM, Will Deacon wrote:
[...]

> What's the advantage of this approach, other than you get an extra byte's
> worth of PID?

In my view, the real advantage is that the the PID is located where people
reading ARM Architecture Reference Manual are told they can find it.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
