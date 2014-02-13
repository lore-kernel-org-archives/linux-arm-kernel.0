From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 13 Feb 2014 11:26:06 +0000
Subject: [PATCH 06/22] Add helper functions used by arm/arm64
In-Reply-To: <1391619853-10601-7-git-send-email-leif.lindholm@linaro.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
 <1391619853-10601-7-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140213112606.GF20717@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Feb, at 05:03:57PM, Leif Lindholm wrote:
> From: Roy Franz <roy.franz@linaro.org>
> 
> Add the get_dram_base() function and efi_call_physN() macros
> that are shared by arm/arm64.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  drivers/firmware/efi/efi-stub-helper.c |   63 +++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 13 deletions(-)

These changes should be in drivers/firmware/efi/arm-stub.c -
efi-stub-helper.c is not a dumping ground for random
architecture-specific code.

-- 
Matt Fleming, Intel Open Source Technology Center
