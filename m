From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 Oct 2018 17:10:05 +0200
Subject: [PATCH 07/11] DT: arm64: exynos7: add support for thermal trip
 irq-mode
In-Reply-To: <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
References: <CGME20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
 <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
Message-ID: <CAJKOXPemhDTF7moU4H=PS=6ZZZRDR7Mobo0Z+-kBd_hw0vB1kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos7?

Beside that comments from previous email apply (no need to duplicate them).

Best regards,
Krzysztof
