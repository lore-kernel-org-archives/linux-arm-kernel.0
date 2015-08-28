From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 28 Aug 2015 14:32:18 +0100
Subject: [PATCH 3/3] efi/arm64: clean up efi_get_fdt_params() interface
In-Reply-To: <1440595498-30630-4-git-send-email-leif.lindholm@linaro.org>
References: <1440595498-30630-1-git-send-email-leif.lindholm@linaro.org>
 <1440595498-30630-4-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20150828133218.GH2759@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug, at 02:24:58PM, Leif Lindholm wrote:
> As we now have a common debug infrastructure between core and arm64 efi,
> drop the bit of the interface passing verbose output flags around.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/arm64/kernel/efi.c    | 2 +-
>  drivers/firmware/efi/efi.c | 6 ++----
>  include/linux/efi.h        | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)

Thanks, applied.

-- 
Matt Fleming, Intel Open Source Technology Center
