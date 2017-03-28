From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Mar 2017 11:22:59 +0200
Subject: [PATCH v4 0/6] Pad retentions support for Exynos5433
In-Reply-To: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170323080346eucas1p216eec41325d220774ecec05b397e83a6@eucas1p2.samsung.com>
 <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CACRpkdY1snu8tNaUW4hR7zvMSMv10wUoeAnv28Ag=NJuHAS-Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 9:03 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> This patchset is a next step to add support for all power domains on
> Exynos5433 SoCs. This patchset contains patches for Exynos pin control
> driver and Exynos LPASS MFD driver, which are needed to make the
> platform ready for adding power domains support.
>
> Patches in this patchset have runtime dependency. They are order in such
> a way to make the changes bisectable (mfd lpass changes should be applied
> after pinctrl patches). Other dependencies mentioned previously in v3 of
> this patchset has been finally merged to v4.11-rc1.
>
> Patches have been rebased on top of linux v4.11-rc3.

Pinctrl development is based on -rc1.

I expect Krzysztof to figure out and apply the patches to his Samsung pinctrl
branch and forward to me, all looks OK to me.

Yours,
Linus Walleij
