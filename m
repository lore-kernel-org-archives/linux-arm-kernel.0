From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 17 Aug 2011 14:37:01 +0900
Subject: [PATCH 0/3] ARM: SAMSUNG: register the second instance of PL330
	DMAC
In-Reply-To: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
References: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CAH9JG2XPA3zAT9A6-2N0CqYC__ac4krW5gTM271qfxJD8DHETQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Does it also need to provide the mdma?

On Wed, Aug 17, 2011 at 1:06 PM, alim akhtar <alim.akhtar@samsung.com> wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
>
> Two instance of platform data is provided for PL330 but only one PL330 DMAC
> instance is registered with amba_device.
> These patch sets registers the second instance with amba_device.
>
> These patches are based on kgene's tree next/topic-dma-pl330 branch.
> http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git;;a=summary
>
> Alim Akhtar (3):
> ?ARM: EXYNOS4: register the second instance of pl330 DMAC
> ?ARM: S5PV210: register the second instance of pl330 DMAC
> ?ARM: S5PC100: register the second instance of pl330 DMAC
>
> ?arch/arm/mach-exynos4/dma.c | ? ?1 +
> ?arch/arm/mach-s5pc100/dma.c | ? ?1 +
> ?arch/arm/mach-s5pv210/dma.c | ? ?1 +
> ?3 files changed, 3 insertions(+), 0 deletions(-)
>
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
