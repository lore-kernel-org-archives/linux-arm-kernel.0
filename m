From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 7 Sep 2017 17:29:18 +0100
Subject: [PATCH] arm64: efi: Don't include EFI fpsimd save/restore code
 in non-EFI kernels
In-Reply-To: <1504193606-14461-1-git-send-email-Dave.Martin@arm.com>
References: <1504193606-14461-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170907162917.t6azerdbcc2e3syn@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 04:33:26PM +0100, Dave P Martin wrote:
> __efi_fpsimd_begin()/__efi_fpsimd_end() are for use when making EFI
> calls only, so using them in non-EFI kernels is not allowed.
> 
> This patch compiles them out if CONFIG_EFI is not set.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Queued for 4.14. Thanks.

-- 
Catalin
