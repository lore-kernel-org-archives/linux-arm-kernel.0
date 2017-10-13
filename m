From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Oct 2017 09:51:09 +0100
Subject: [PATCH/RFC 2/5] mfd: bd9571mwv: Add DDR Backup Power register
 bit definitions
In-Reply-To: <1507649178-31473-3-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20171013085109.m264vnvvorbwnw42@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:

> Add definitions for the KEEPON_* bits in the "BKUP Mode Cnt" register,
> which control the DDR rails to be kept powered when backup mode is
> enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/mfd/bd9571mwv.h | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
