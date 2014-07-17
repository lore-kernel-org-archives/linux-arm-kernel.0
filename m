From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 12:03:33 +0100
Subject: [PATCHv4 0/5] arm64: handle heterogeneous system register values
In-Reply-To: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20140717110332.GE18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:32:42PM +0100, Mark Rutland wrote:
> Mark Rutland (5):
>   arm64: add MIDR_EL1 field accessors
>   arm64: cpuinfo: record cpu system register values
>   arm64: cachetype: report weakest cache policy
>   arm64: add runtime system sanity checks

For these 4 patches:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

>   arm64: cpuinfo: print info for all CPUs

This is still up for discussion.

-- 
Catalin
