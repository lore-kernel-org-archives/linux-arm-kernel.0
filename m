From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 17 Dec 2010 14:44:26 +0900
Subject: [PATCH 14/17] ARM: S5PV310: Define I2S clocks
In-Reply-To: <1292562014-20036-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
	<1292562014-20036-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <AANLkTi=sh4if3FhU2-yUrFCUAtjWm4mDaMcf_JSTU8ia@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Don't you use the i2s instead of iis?

Thank you,
Kyungmin Park

On Fri, Dec 17, 2010 at 2:00 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
>
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
> ?arch/arm/mach-s5pv310/clock.c | ? 15 +++++++++++++++
> ?1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
> index 189198a..6d22c43 100644
> --- a/arch/arm/mach-s5pv310/clock.c
> +++ b/arch/arm/mach-s5pv310/clock.c
> @@ -517,6 +517,21 @@ static struct clk init_clocks_disable[] = {
> ? ? ? ? ? ? ? ?.enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> ? ? ? ? ? ? ? ?.ctrlbit ? ? ? ?= (1 << 18),
> ? ? ? ?}, {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "iis",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 0,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 19),
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "iis",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 1,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 20),
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "iis",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 2,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 21),
> + ? ? ? }, {
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "ac97",
> ? ? ? ? ? ? ? ?.id ? ? ? ? ? ? = -1,
> ? ? ? ? ? ? ? ?.enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
