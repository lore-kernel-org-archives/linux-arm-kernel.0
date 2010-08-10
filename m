From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Aug 2010 15:46:59 -0700
Subject: [PATCH] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <1280890950-19174-1-git-send-email-sboyd@codeaurora.org>
References: <1280890950-19174-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <4C61D6E3.1030603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2010 08:02 PM, Stephen Boyd wrote:
> This is mostly a copy from the s390 implementation (which copied
> from x86 and sparc), except we print a warning if the Kconfig
> option is disabled.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>

Ping?

Should I submit this to the patch system?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
