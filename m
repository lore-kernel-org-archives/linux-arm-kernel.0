From: monstr@monstr.eu (Michal Simek)
Date: Wed, 21 Dec 2011 11:22:34 +0100
Subject: [RFC 1/8] gpio/microblaze: Eliminate duplication of
 of_get_named_gpio_flags()
In-Reply-To: <1320801583-12774-2-git-send-email-grant.likely@secretlab.ca>
References: <1320801583-12774-1-git-send-email-grant.likely@secretlab.ca>
 <1320801583-12774-2-git-send-email-grant.likely@secretlab.ca>
Message-ID: <4EF1B36A.8050304@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> of_reset_gpio_handle() is largely a cut-and-paste copy of
> of_get_named_gpio_flags(). There really isn't any reason for the
> split, so this patch deletes the duplicate function
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/kernel/reset.c |   43 +--------------------------------------
>  1 files changed, 2 insertions(+), 41 deletions(-)

Sorry for taking to long.

Tested and applied to microblaze tree.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
