From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 May 2013 14:50:28 -0700
Subject: [PATCH] ARM: avoid mis-detecting some V7 cores in the decompressor
In-Reply-To: <1368049671-22879-1-git-send-email-sboyd@codeaurora.org>
References: <1368049671-22879-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <518AC8A4.8070701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/13 14:47, Stephen Boyd wrote:
> From: Brian Swetland <swetland@google.com>
>
> Currently v7 CPUs with an MIDR that has no bits set in the range
> [16:12] will be detected as old ARM CPUs with no caches and so

I mean [15:12], sorry.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
