From: robert.richter@amd.com (Robert Richter)
Date: Wed, 6 Oct 2010 14:41:05 +0200
Subject: [PATCH 3/7] ARM: oprofile: Rename op_arm to oprofile_perf
In-Reply-To: <094e8a33da82ce840f77fd1f7646391c08205b6e.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<094e8a33da82ce840f77fd1f7646391c08205b6e.1286222593.git.matt@console-pimps.org>
Message-ID: <20101006124105.GN13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.10.10 16:44:21, Matt Fleming wrote:
> In preparation for moving the generic functions out of this file, give
> the functions more general names (e.g. remove "arm" from the names).
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Tested-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/oprofile/common.c |   68 ++++++++++++++++++++++----------------------
>  1 files changed, 34 insertions(+), 34 deletions(-)

This patch looks good.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
