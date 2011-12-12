From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Dec 2011 09:20:43 +0800
Subject: [PATCH v3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <1323183883-32161-1-git-send-email-shawn.guo@linaro.org>
References: <1322731268-12158-2-git-send-email-shawn.guo@linaro.org>
 <1323183883-32161-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111212012043.GB9572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

Ping?

Regards,
Shawn

On Tue, Dec 06, 2011 at 11:04:43PM +0800, Shawn Guo wrote:
> It adds device tree probe support for mc13xxx mfd driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> Changes since v2:
> 
>  * Add some note on how driver matches regulator device and the node
>    in binding document
> 
> Since it's a small change, I only resend this patch (as v3) instead
> of the whole series.  Hope it's fine.
> 
> Regards,
> Shawn
> 
>  Documentation/devicetree/bindings/mfd/mc13xxx.txt |   53 ++++++++++
>  drivers/mfd/mc13xxx-core.c                        |  106 +++++++++++++++------
>  2 files changed, 128 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mc13xxx.txt
