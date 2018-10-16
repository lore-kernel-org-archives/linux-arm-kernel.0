From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 Oct 2018 17:13:03 +0200
Subject: [PATCH 09/11] DT: arm: exynos: add support for thermal trip
 irq-mode
In-Reply-To: <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
References: <CGME20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8@eucas1p1.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
 <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
Message-ID: <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos5420? 4 trip points?

BTW, I just noted that you skipped samsung-soc mailing list.

DTS patches always should go through arm-soc so in case of Exynos -
linux-samsung-soc mailing list. The list should be also CC-ed if you
touch other Exynos or Samsung related code and get_maintainers.pl
always point it. Because you skipped it, some people might miss your
patches and definitely Patchwork which I am using won't see them
(https://patchwork.kernel.org/project/linux-samsung-soc/list/).

Best regards,
Krzysztof
