From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 May 2017 14:15:52 +0530
Subject: [PATCH v5 3/3] phy: Group vendor specific phy drivers
In-Reply-To: <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
 <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <5fe76bcc-5ff7-0bf1-7fdd-c141211d86dc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Thursday 11 May 2017 12:17 PM, Vivek Gautam wrote:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> 
> Also updated the MAINTAINERS file to reflect the correct
> directory structure for phy drivers.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-usb at vger.kernel.org
> ---
> 
> Changes since v4:
>  - Reprepared the patch based on latest torvalds/master.
>  - Added new directory for amlogic, since there's a new patch [1]
>    coming in for amlogic platforms.

I don't prefer placeholder directories but this is not a placeholder directory
since phy-meson8b-usb2.c is already added in amlogic.

Btw, thank you for sending this patch. Will queue this once -rc1 is tagged.

Cheers
Kishon
