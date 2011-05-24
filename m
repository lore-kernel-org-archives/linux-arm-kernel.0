From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 May 2011 14:59:53 -0700
Subject: [PATCH 0/5] ARMv6 and ARMv7 mm fixes
In-Reply-To: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
References: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
Message-ID: <4DDC2A59.8030109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2011 04:19 AM, Will Deacon wrote:
> Hello,
>
> There are a few issues with ASID handling and cache flushing on v6/v7
> CPUs that have been identified when running Linux on the Cortex-A15.
>
> These patches solve the problems for the classic page tables. Additional
> LPAE changes will be posted separately.
>
> Tested on a Realview-PBX platform with a dual-core Cortex-A9.

Should these patches be sent to the stable tree? Or do the problems only
manifest on Cortex-A15?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
