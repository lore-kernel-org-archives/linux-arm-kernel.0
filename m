From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 15 Mar 2017 09:08:44 +0100
Subject: [RESEND PATCH v3 2/2] phy: Group vendor specific phy drivers
In-Reply-To: <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1489472080-23711-2-git-send-email-vivek.gautam@codeaurora.org>
 <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <2492681.1VCl1nfEs0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. M?rz 2017, 11:52:50 CET schrieb Vivek Gautam:
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
> ---
> 
> Corrected Krzysztof's email-id. Added linux-arm-msm.
> 
> Hi Heiko, Viresh,
> It's been a year since the last version of this patch was posted.
> Kishon has agreed to pull this change now. I am carrying forward
> your Acks since there are no functional changes.
> I have taken care of the drivers that were added/removed since
> the last version.
> Please feel free to jump in if you have any concerns.

still looks all good and I gave that a try on 4.11-rc2 yesterday as well.


Heiko
