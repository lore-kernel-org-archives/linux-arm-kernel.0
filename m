From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 13:59:37 +0800
Subject: [PATCHv2 0/7] ARM: imx: add IMX50 SoC support
In-Reply-To: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
Message-ID: <20131031055935.GB23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:15:50PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> This set of patches is the code and device tree support for the Freescale
> IMX50 SoC. This part is similar to the IMX53 SoC family, and I have resued
> as much of its support as possible. These patches are against Shawn Guo's
> linux-2.6.git for-next branch.
> 
> This loads and runs on the Freescale IMX50-EVK board.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
> v2: made the pinctrl changes a separate patch stream
>     fixups for applying to Shawn's for-next branch
>     initial values for some pad control settings

Thanks for the respin.  I just applied the series except patch #3, where
I still have some small comment.

Shawn
