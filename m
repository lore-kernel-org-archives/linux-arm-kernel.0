From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 17 Mar 2016 13:34:34 -0500
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <56EAF244.2090805@caviumnetworks.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
 <56E97B10.4050401@codeaurora.org>
 <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
 <56EAF244.2090805@caviumnetworks.com>
Message-ID: <56EAF8BA.8060305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Pinski wrote:
>>
>
> Note ThunderX's SOC have customers  where some are embedded users
> (uboot) and server users (UEFI).  The cores always have 128 byte
> cacheline size.  So please don't make this dependent on ACPI.  Note the
> defconfig works correctly on T88.

This thread is getting off-topic.  There's nothing about the cacheline 
size that is dependent on ACPI or DT.  Catalin was wondering why we have 
our own defconfig for our ARM64 SOC, and I replied that it's because 
ACPI is not enabled yet in the upstream defconfig.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
