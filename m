From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Oct 2017 18:13:16 +0100
Subject: [PATCH v3 23/28] arm64/sve: KVM: Treat guest SVE use as
 undefined instruction execution
In-Reply-To: <1507660725-7986-24-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-24-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171012171315.47d3bd5sq76eoqmd@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:40PM +0100, Dave P Martin wrote:
> When trapping forbidden attempts by a guest to use SVE, we want the
> guest to see a trap consistent with SVE not being implemented.
> 
> This patch injects an undefined instruction exception into the
> guest in response to such an exception.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
