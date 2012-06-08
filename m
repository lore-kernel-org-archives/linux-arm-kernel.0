From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 8 Jun 2012 11:40:21 +0530
Subject: [CFT 11/11] Add feature removal of old OMAP private DMA
 implementation
In-Reply-To: <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Message-ID: <CAMQu2gzaC0KCJ5MEozRdQoQL_JOm4RpBkNbwv0RDEstheBwntQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 4:39 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?Documentation/feature-removal-schedule.txt | ? 11 +++++++++++
> ?1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 56000b3..1f7ba35 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -612,3 +612,14 @@ When: ? ? ?June 2013
> ?Why: ? Unsupported/unmaintained/unused since 2.6
>
> ?----------------------------
> +
> +What: ?OMAP private DMA implementation
> +When: ?2013
> +Why: ? We have a DMA engine implementation; all users should be updated
> + ? ? ? to use this rather than persisting with the old APIs. ?The old APIs
> + ? ? ? block merging the old DMA engine implementation into the DMA
> + ? ? ? engine driver.
> +Who: ? Russell King <linux@arm.linux.org.uk>,
> + ? ? ? Santosh Shilimkar <santosh.shilimkar@ti.com>
> +
> +----------------------------
> --

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
