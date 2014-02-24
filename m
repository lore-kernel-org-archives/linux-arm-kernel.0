From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Feb 2014 11:29:18 +0530
Subject: [PATCH 1/5] mmc: sdhci-spear: fix error handling paths for DT
In-Reply-To: <E1WGnXX-0007Jg-JR@rmk-PC.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
 <E1WGnXX-0007Jg-JR@rmk-PC.arm.linux.org.uk>
Message-ID: <CAKohpok+p+7uBhO3GF18fSOTCb-=29sH7Ua_fSsGFzPc83bgsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 February 2014 16:11, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> Fix the error handling paths for DT and simplify using the devm_* API
> for clk_get().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-spear.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

For all patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
