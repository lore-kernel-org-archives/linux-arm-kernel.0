From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Oct 2017 15:19:05 +0100
Subject: [PATCH v3 05/28] arm64: fpsimd: Simplify uses of {set,
 clear}_ti_thread_flag()
In-Reply-To: <1507660725-7986-6-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-6-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171011141904.n7mi6rwmmprvcg27@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:22PM +0100, Dave P Martin wrote:
> The existing FPSIMD context switch code contains a couple of
> instances of {set,clear}_ti_thread(task_thread_info(task)).  Since
> there are thread flag manipulators that operate directly on
> task_struct, this verbosity isn't strictly needed.
> 
> For consistency, this patch simplifies the affected calls.  This
> should have no impact on behaviour.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
