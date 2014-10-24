From: drake@endlessm.com (Daniel Drake)
Date: Fri, 24 Oct 2014 07:23:49 -0600
Subject: [PATCH 5/5] ARM: dts: Add dts files for Exynos4415 SoC
In-Reply-To: <1413775935-17743-5-git-send-email-cw00.choi@samsung.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>
 <1413775935-17743-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAD8Lp46Y1WBF2Bq5SKtQDZ4kUb2fDCsbBs1THFWcV=8-OXh_SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 19, 2014 at 9:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch adds new exynos4415.dtsi to support Exynos4415 SoC
> based on Cortex-A9 quad cores and includes following dt nodes:

There's a lot in common between your new exynos4415.dtsi and the
existing exynos4.dtsi.
Would it make more sense for the 4415 code to extend the existing
exynos4.dtsi like the other Exynos4 variants do?

Thanks
Daniel
