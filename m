From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 26 Aug 2015 18:25:41 +0100
Subject: [PATCH 1/3] efi/x86: move efi=debug option parsing to core
In-Reply-To: <1440595498-30630-2-git-send-email-leif.lindholm@linaro.org>
References: <1440595498-30630-1-git-send-email-leif.lindholm@linaro.org>
 <1440595498-30630-2-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20150826172541.GC2837@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug, at 02:24:56PM, Leif Lindholm wrote:
> fed6cefe3b6e ("x86/efi: Add a "debug" option to the efi= cmdline")
> adds the DBG flag, but does so for x86 only. Move this early param
> parsing to core code.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/x86/platform/efi/efi.c | 2 --
>  drivers/firmware/efi/efi.c  | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)

Nice clean up. Thanks Leif, applied.

-- 
Matt Fleming, Intel Open Source Technology Center
