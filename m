From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 04 Aug 2018 15:16:01 +0200
Subject: [PATCH v4 2/4] arm64: dts: rockchip: add GRF GPIO controller to
 rk3328
In-Reply-To: <1533016762-5268-3-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
 <1533016762-5268-3-git-send-email-djw@t-chip.com.cn>
Message-ID: <4016409.aba6YNvtTb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Levin,

Am Dienstag, 31. Juli 2018, 07:59:20 CEST schrieb djw at t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Adding a GRF GPIO controller labled "grf_gpio" to rk3328, currently
> providing access to the GPIO_MUTE pin, which is manupulated by the
> GRF_SOC_CON10 register.
> 
> The GPIO_MUTE pin is referred to as <&grf_gpio 0>.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

applied to my dts64 branch, with 2 changes:
- reordered, please sort nodes without address alphabetically
- removed default disabled status
  The controlled pin is always present on the soc, so doesn't need
  to be enabled on a per-board level


Heiko
