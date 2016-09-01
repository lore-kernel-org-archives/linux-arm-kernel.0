From: bp@alien8.de (Borislav Petkov)
Date: Thu, 1 Sep 2016 08:15:14 +0200
Subject: [Patch v5 8/9] driver/edac/layerscape_edac: Add Layerscape EDAC
 support
In-Reply-To: <1471990465-27443-1-git-send-email-york.sun@nxp.com>
References: <1471990465-27443-1-git-send-email-york.sun@nxp.com>
Message-ID: <20160901061514.GC16153@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 03:14:03PM -0700, York Sun wrote:
> Add DDR EDAC for ARM-based compatible controllers. Both big-endian
> and little-endian are supported, as specified in device tree.
> 
> Signed-off-by: York Sun <york.sun@nxp.com>
> 
> ---
> Change log
>   v5: Update author and copyright for the new driver
>       Drop initializing varaible with 0
>       Add pr_fmt macro
>   v4: Drop adding atomic_scrub() for armv8
>       Drop NO_IRQ
>   v3: no change
>   v2: Create new driver using shared DDR object
> 
>  arch/arm64/Kconfig.platforms   |  1 +
>  drivers/edac/Kconfig           |  7 ++++
>  drivers/edac/Makefile          |  3 ++
>  drivers/edac/fsl_ddr_edac.c    |  2 +-
>  drivers/edac/layerscape_edac.c | 73 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/edac/layerscape_edac.c

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
