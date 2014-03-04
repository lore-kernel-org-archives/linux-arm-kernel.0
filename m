From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 04 Mar 2014 12:29:05 -0800
Subject: [PATCH] [RESEND] ARM: footbridge: remove obsolete IRQF_DISABLED
In-Reply-To: <1393964413-16829-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1386395865-11910-1-git-send-email-michael.opdenacker@free-electrons.com>
 <1393964413-16829-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <53163791.50202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/14 12:20, Michael Opdenacker wrote:
> This patch proposes to remove the IRQF_DISABLED flag from footbridge
> code. It's a NOOP since 2.6.35.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

You should send this to Russell's patch tracker[1] given that nobody has
commented in over 6 months on two resends.

[1] http://www.arm.linux.org.uk/developer/patches/info.php

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
