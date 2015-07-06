From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 6 Jul 2015 17:15:31 +0100
Subject: [PATCH] arm64: remove another unnecessary libfdt include path
In-Reply-To: <1436195289-20904-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1436195289-20904-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150706161531.GF27723@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 05:08:09PM +0200, Ard Biesheuvel wrote:
> Patch 63a4aea55670 ("of: clean-up unnecessary libfdt include paths")
> removed all explicit libfdt include paths, since those are no longer
> necessary after the latest dtc upgrade. However, this one snuck in
> during the same merge window. Remove it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This should go on top of 4.2-rc1, since the mentioned patch was merged
> through the DT tree.

Applied. Thanks.

-- 
Catalin
