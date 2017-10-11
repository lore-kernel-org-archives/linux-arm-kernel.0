From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Oct 2017 15:29:51 +0100
Subject: [PATCH v3 09/28] arm64/sve: Signal frame and context structure
 definition
In-Reply-To: <1507660725-7986-10-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-10-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171011142950.zdhpaenvz4u5oyc3@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:26PM +0100, Dave P Martin wrote:
> This patch defines the representation that will be used for the SVE
> register state in the signal frame, and implements support for
> saving and restoring the SVE registers around signals.
> 
> The same layout will also be used for the in-kernel task state.
> 
> Due to the variability of the SVE vector length, it is not possible
> to define a fixed C struct to describe all the registers.  Instead,
> Macros are defined in sigcontext.h to facilitate access to the
> parts of the structure.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
