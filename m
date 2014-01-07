From: bp@alien8.de (Borislav Petkov)
Date: Wed, 8 Jan 2014 00:43:27 +0100
Subject: [PATCH v4 5/6] edac: Add support for Krait CPU cache error
 detection
In-Reply-To: <1388434457-4194-6-git-send-email-sboyd@codeaurora.org>
References: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
 <1388434457-4194-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140107234327.GH4164@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 12:14:16PM -0800, Stephen Boyd wrote:
> Add support for the Krait CPU cache error detection. This is a
> simplified version of the code originally written by Stepan
> Moskovchenko[1] ported to the EDAC device framework.
> 
> [1] https://www.codeaurora.org/cgit/quic/la/kernel/msm/tree/arch/arm/mach-msm/cache_erp.c?h=msm-3.4
> 
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/edac/Kconfig      |   8 ++
>  drivers/edac/Makefile     |   2 +
>  drivers/edac/krait_edac.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 356 insertions(+)
>  create mode 100644 drivers/edac/krait_edac.c

Looks nice and clean, applied.

So, patch 1/6 I'm taking anyway as it is a bugfix - for the others I'll
wait until 3/6 is cleared which way/how it goes.

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
