From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Aug 2013 11:05:36 +0100
Subject: [PATCH] arm64: Add EM_AARCH64 to elf-em.h
In-Reply-To: <1377812307.23710.3.camel@smoke>
References: <1377812307.23710.3.camel@smoke>
Message-ID: <20130830100535.GE62188@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 10:38:27PM +0100, Geoff Levand wrote:
> Add the elf EM value for ARM's AArch64.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> 
> Hi Catalin,
> 
> Please apply if you don't have it yet.

There was a patch moving EM_ARM as well (both for compat and AArch32)
and I'll happily push it but I'm waiting for Russell's ack.

-- 
Catalin
