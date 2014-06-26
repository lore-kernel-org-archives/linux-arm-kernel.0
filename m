From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 26 Jun 2014 11:33:30 +0900
Subject: [PATCH 1/2] ARM: firmware: Introduce suspend and resume operations
In-Reply-To: <1403713114-18923-2-git-send-email-t.figa@samsung.com>
References: <1403713114-18923-1-git-send-email-t.figa@samsung.com>
 <1403713114-18923-2-git-send-email-t.figa@samsung.com>
Message-ID: <53AB867A.901@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2014 01:18 AM, Tomasz Figa wrote:
> This patch extends the firmware_ops structure with two new callbacks:
> .suspend() and .resume(). The former is intended to ask the firmware to
> save all its volatile state and suspend the system, without returning
> back to the kernel in between. The latter is to be called early by
> very low level platform suspend code after waking up to restore low
> level hardware state, which can't be restored in non-secure mode.
>
> While at it, outdated version of the structure is removed from the
> documentation and replaced with a reference to the header file.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
