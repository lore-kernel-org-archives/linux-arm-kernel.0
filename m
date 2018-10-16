From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 Oct 2018 17:10:44 +0200
Subject: [PATCH 08/11] DT: arm: exynos4: add support for thermal trip
 irq-mode
In-Reply-To: <20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0~eHqOSKKqJ2135421354eucas1p2J@eucas1p2.samsung.com>
References: <CGME20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
 <20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0~eHqOSKKqJ2135421354eucas1p2J@eucas1p2.samsung.com>
Message-ID: <CAJKOXPews4f8Js89AJ7Zz4GUT7ama9LKu1xP-OcV-0Kq28p-bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos4? 4 trip points?

Beside that other comments apply as well.

Best regards,
Krzysztof
