From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2011 23:29:06 +0100
Subject: [PATCH v2 0/3] Fix Thumb-2 undef handling for mixed-arch kernels
In-Reply-To: <1313686914-29481-1-git-send-email-dave.martin@linaro.org>
References: <1313686914-29481-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110818222906.GD28546@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 06:01:51PM +0100, Dave Martin wrote:
> In kernels which support v6 and v7 platforms in a single binary
> such as omap2plus_defconfig for example, undefined instruction
> exceptions taken on Thumb instructions are not processed correctly,
> because the kernel assumes at build-time that Thumb-2 won't be
> supported in userspace.

Unless there's any further comments from anyone, I think this is now
ready.  Thanks.
