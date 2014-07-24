From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 24 Jul 2014 14:20:45 -0400
Subject: [PATCH 0/3] Bunch of vdso cleanups following feedback from x86
In-Reply-To: <1404930133-30324-1-git-send-email-will.deacon@arm.com>
References: <1404930133-30324-1-git-send-email-will.deacon@arm.com>
Message-ID: <53D14E7D.3070706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 07/09/2014 02:22 PM, Will Deacon wrote:
> Hi all,
> 
> Following useful discussions with Andy (thanks!), I've put together the
> following (lightly tested) series for arm64 which attempts to address
> issues with our current vdso code.
> 
> Please take a look. Cheers,

With appropriate updates to Checkpoint and Restore In Userspace (CRIU) [1] and
some finishing touches to its AArch64 port that I hope to publish very soon, I
see no regressions running its VDSO test cases, which exercise basic
discovery, use, and remapping.

Tested-by: Christopher Covington <cov@codeaurora.org>

1. http://lists.openvz.org/pipermail/criu/2014-July/015138.html

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
