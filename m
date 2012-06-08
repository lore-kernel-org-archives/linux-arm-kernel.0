From: rob@landley.net (Rob Landley)
Date: Fri, 08 Jun 2012 13:37:11 -0500
Subject: [CFT 11/11] Add feature removal of old OMAP private DMA
 implementation
In-Reply-To: <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Message-ID: <4FD24657.5020207@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2012 06:09 AM, Russell King wrote:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/feature-removal-schedule.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 56000b3..1f7ba35 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -612,3 +612,14 @@ When:	June 2013
>  Why:	Unsupported/unmaintained/unused since 2.6
>  
>  ----------------------------
> +
> +What:	OMAP private DMA implementation
> +When:	2013
> +Why:	We have a DMA engine implementation; all users should be updated
> +	to use this rather than persisting with the old APIs.  The old APIs
> +	block merging the old DMA engine implementation into the DMA
> +	engine driver.
> +Who:	Russell King <linux@arm.linux.org.uk>,
> +	Santosh Shilimkar <santosh.shilimkar@ti.com>
> +
> +----------------------------

Whose tree do feature-removal-schedule patches go in through?

(They're not really documentation, they're design coordination/logistics.)

Rob

-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
