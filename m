From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 6 Dec 2011 08:24:30 +0900
Subject: [PATCH v7 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20111205154715.GE25178@amd.com>
References: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
 <20111205154715.GE25178@amd.com>
Message-ID: <CAH9JG2VALcm-PreS7S2SZPPgEbid_6_VWJA0PHBEtY5KvaA3Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/6/11, Joerg Roedel <joerg.roedel@amd.com> wrote:
> On Fri, Nov 18, 2011 at 06:47:28PM +0900, KyongHo Cho wrote:
>> Patch Summary:
>> [PATCH v7 1/2] ARM: EXYNOS: Change System MMU platform device definitions
>> [PATCH v7 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
>
> Okay, I merged it into arm/exynos, but it is not pushed yet. Actually
> there were conflicts while merging, which I resolved. What I failed
> to find is a config for Exynos that actually builds for upstream Linux.
> Probably I havn't tried hard enough to find one... Can you provide a
> kernel config that I can use for my testing and that builds a current
> 3.2-rc4 kernel for Exynos?
and I hope to see the real example how to use it with exynos platform.

Now I can't find the interface between exynos platform and generic exynos iommu.
BTW, how do you test it at mainline kernel?

Thank you,
Kyungmin Park

>
> Thanks,
>
> 	Joerg
>
> --
> AMD Operating System Research Center
>
> Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
> General Managers: Alberto Bozzo, Andrew Bowd
> Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.
> 43632
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
