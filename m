From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 24 May 2014 00:55:36 +0200
Subject: [PATCH v10 1/3] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <CANhyOUfp1AL6wJ1Q9kWj=v-n9e2CyxkQOPb8_50M5bY_JN2f9A@mail.gmail.com>
References: <1400841343-6016-1-git-send-email-t.dakhran@samsung.com>	<1400841343-6016-2-git-send-email-t.dakhran@samsung.com>	<537FB995.5070604@gmail.com>	<CANhyOUd8Q2nzh_bF6LZNuv8keVUB3F45PocYrLP_B=D_Q3tWuQ@mail.gmail.com>
 <CANhyOUfp1AL6wJ1Q9kWj=v-n9e2CyxkQOPb8_50M5bY_JN2f9A@mail.gmail.com>
Message-ID: <537FD1E8.2090705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.05.2014 00:48, Tarek Dakhran wrote:
> Sorry, only now catch it!
> I agree, this patch is not needed anymore, except Kconfig option.
> config SOC_EXYNOS5410 is needed to build clock stuff.

Right, I missed this.

> What is your opinion, Tomasz?
> 

I'd suggest re-spinning this series once more, removing changes that are
not needed anymore, but keeping the Kconfig entry.

Best regards,
Tomasz
