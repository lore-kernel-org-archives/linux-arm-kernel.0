From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 4 Nov 2013 09:51:51 -0500
Subject: [PATCHv3] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
References: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
Message-ID: <20131104145151.GD3060@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Mon, Nov 04, 2013 at 10:13:40AM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Add machine support code for the Freescale IMX50 SoC.
> 
> The IMX50 is quite similar to the Freescale IMX53, and contains many of the
> same periperhal hardware modules, at the same address offsets as the IMX53.
> (Notable exceptions are that the IMX50 contains no CAN bus hardware, less
> GPIO, no VPU, it does contain an Electrophoretic display controller though).
> 
> This support code uses some of the IMX53 setup code to reduce duplication
> of what would be identical init IO setup.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/mach-imx/Makefile     |  1 +
>  arch/arm/mach-imx/common.h     |  1 +
>  arch/arm/mach-imx/mach-imx50.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+)
>  create mode 100644 arch/arm/mach-imx/mach-imx50.c

What happened to the rest of the series?  If this is a new version of
just a single patch in the V2 series (which I suspect it is), we usually
make it an in-reply-to the previous version of the patch it replaces.
Not a big deal, it just helps us keep track of things more easily.

thx,

Jason.
