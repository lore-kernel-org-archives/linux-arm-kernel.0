From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 Oct 2018 15:05:54 +0200
Subject: [PATCH v2 5/6] arm64: dts: exynos: Move arch-timer node to right
 place
In-Reply-To: <20181015123112.9379-6-m.szyprowski@samsung.com>
References: <CGME20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017@eucas1p2.samsung.com>
 <20181015123112.9379-1-m.szyprowski@samsung.com>
 <20181015123112.9379-6-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPct1-8g6hcfzwkMdyFDJPfj=5Y9-s0R9mtpTJu99in7Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Oct 2018 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Move ARM architected timer device-tree node to the beginning of 'soc'
> node, to group it together with other ARM CPU core devices (like PMU).
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Looks okay, I'll take it after this merge window.

Best regards,
Krzysztof
