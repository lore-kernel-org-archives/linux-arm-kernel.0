From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 14 Mar 2017 17:04:25 +0900
Subject: [RESEND PATCH v3 2/2] phy: Group vendor specific phy drivers
In-Reply-To: <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1489472080-23711-2-git-send-email-vivek.gautam@codeaurora.org>
 <CGME20170314062341epcas1p4ac40ea145b811f29e42df57bed5121a0@epcas1p4.samsung.com>
 <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <8f1ec0f2-e824-12a3-f7e3-ec02eb3b307f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2017 03:22 PM, Vivek Gautam wrote:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> 
> Also updated the MAINTAINERS file to reflect the correct
> directory structure for phy drivers.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-usb at vger.kernel.org

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

[..snip..]

> ---
