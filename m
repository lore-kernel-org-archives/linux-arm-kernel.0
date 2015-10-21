From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Oct 2015 10:21:43 +0100
Subject: [PATCHv4 06/24] arm64: Move /proc/cpuinfo handling code
In-Reply-To: <20151021090050.GG4801@e103592.cambridge.arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
 <1445261101-22344-7-git-send-email-suzuki.poulose@arm.com>
 <20151021090050.GG4801@e103592.cambridge.arm.com>
Message-ID: <20151021092142.GN11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 10:00:51AM +0100, Dave P Martin wrote:
> From ab00f84e4d45e95b4d816961a0160f1d448aa886 Mon Sep 17 00:00:00 2001
> From: Dave Martin <Dave.Martin@arm.com>
> Date: Thu, 30 Jul 2015 16:36:25 +0100
> Subject: [PATCH 1/2] arm64: Constify hwcap name string arrays
> 
> The hwcap string arrays used for generating the contents of
> /proc/cpuinfo are currently arrays of non-const pointers.
> 
> There's no need for these pointers to be mutable, so this patch makes
> them const so that they can be moved to .rodata.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Thanks Dave. I applied this on top of Suzuki's series.

-- 
Catalin
