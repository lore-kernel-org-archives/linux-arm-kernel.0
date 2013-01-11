From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Jan 2013 21:51:55 -0800
Subject: [PATCH 3/3] ARM: samsung: remove unused arch_decomp_wdog() code
In-Reply-To: <1357827165-9320-4-git-send-email-shawn.guo@linaro.org>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <1357827165-9320-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <041c01cdefbf$c46fddb0$4d4f9910$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> 
> With ARCH_HAS_DECOMP_WDOG removed from
> arch/arm/boot/compressed/decompress.c,
> all the arch_decomp_wdog() related codes become unused.  Remove them.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Looks good to me,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Do you want me to take this into Samsung tree?

- Kukjin
