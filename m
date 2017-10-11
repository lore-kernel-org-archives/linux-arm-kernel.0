From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Oct 2017 15:20:20 +0100
Subject: [PATCH v3 06/28] arm64/sve: System register and exception
 syndrome definitions
In-Reply-To: <1507660725-7986-7-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-7-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171011142020.ncrsol5lptqdwajz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:23PM +0100, Dave P Martin wrote:
> The SVE architecture adds some system registers, ID register fields
> and a dedicated ESR exception class.
> 
> This patch adds the appropriate definitions that will be needed by
> the kernel.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
