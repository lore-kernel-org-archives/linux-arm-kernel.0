From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Feb 2016 18:03:13 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <1454684330-892-1-git-send-email-james.morse@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
Message-ID: <20160218180313.GE2538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 02:58:45PM +0000, James Morse wrote:
> James Morse (5):
>   arm64: cpufeature: Change read_cpuid() to use sysreg's mrs_s macro
>   arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
>   arm64: kernel: Add support for User Access Override
>   arm64: cpufeature: Test 'matches' pointer to find the end of the list
>   arm64: kernel: Don't toggle PAN on systems with UAO

Patches applied with an additional fixup on top for removing
get_thread_info().

Thanks.

-- 
Catalin
