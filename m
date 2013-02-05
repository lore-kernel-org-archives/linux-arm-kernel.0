From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 5 Feb 2013 09:15:56 +0100
Subject: [PATCH] vexpress: Allow vexpress-sysreg to self-initialise
In-Reply-To: <1360001282-25554-1-git-send-email-catalin.marinas@arm.com>
References: <1360001282-25554-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20130205081556.GL8476@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Mon, Feb 04, 2013 at 06:08:02PM +0000, Catalin Marinas wrote:
> The vexpress_sysreg_init() is a core_initcall() already and it can
> trigger the early initialisation if a matching node is found. This patch
> allows the SoC code to avoid calling vexpress_sysreg_of_early_init()
> explicitly.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
> ---
> 
> Samuel, could you please merge this patch for 3.9 (based on 3.8-rc6)? It is
> needed for arm64 support (which shares the same mfd files with the 32-bit arm
> port). Thanks.
Applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
