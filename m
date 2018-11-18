From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 18 Nov 2018 02:26:07 +0100
Subject: [PATCH] clockevents/drivers/tegra20: Remove obsolete inclusion of
 <asm/smp_twd.h>
In-Reply-To: <20181115100037.17706-1-geert+renesas@glider.be>
References: <20181115100037.17706-1-geert+renesas@glider.be>
Message-ID: <0f432792-cdaa-e1bd-1357-326b08ce0a83@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2018 11:00, Geert Uytterhoeven wrote:
> As of commit da4a686a2cfb077a ("ARM: smp_twd: convert to use CLKSRC_OF
> init"), this header file is no longer used.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
Applied.

Thanks!

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
