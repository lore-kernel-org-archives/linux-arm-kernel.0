From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Jun 2017 14:54:19 +0200
Subject: [PATCH v4 0/8] MFD: add driver for HiSilicon Hi6421v530 PMIC
In-Reply-To: <20170606085143.13154-1-guodong.xu@linaro.org>
References: <20170606085143.13154-1-guodong.xu@linaro.org>
Message-ID: <CAK8P3a25o6HOFw4MWrsnKjHJf4YuO+UvGk+=f30LREnFHM3QwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 10:51 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
> This patchset adds driver for HiSilicon Hi6421v530 PMIC.
>
> Mainline kernel already has driver support to a similar chip, Hi6421.
> Hi6421 and Hi6421v530 are both from the same vendor, HiSilicon, but
> they are at different revisions. They both use the same Memory-mapped
> I/O method to communicate with Main SoC. However, they differ quite a
> lot in their regulator designs. Eg. they have completely different LDO
> voltage points.
>
> Patch 1 and 2 are hi6421-pmic cleaning up.
> Patch 3 and 4 extends hi6421-pmic-core.c to support Hi6421v530 revision.
> Patch 5 add hi6421v530-regulator.c driver for LDO regulators.
> Patch 6 fixes an issue for hi6421 regulator, which is not related to v530
>          but it's found in this review.
> Patch 7 is dts change, it depends on and can be applied to hi3660/hikey960
>         patchset [1].
> Patch 8 enables the relevant config items.

Looks good to me,

    Arnd
