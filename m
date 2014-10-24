From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 24 Oct 2014 15:30:01 +0200
Subject: [PATCH 5/5] ARM: dts: Add dts files for Exynos4415 SoC
In-Reply-To: <CAD8Lp46Y1WBF2Bq5SKtQDZ4kUb2fDCsbBs1THFWcV=8-OXh_SQ@mail.gmail.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>	<1413775935-17743-5-git-send-email-cw00.choi@samsung.com>
 <CAD8Lp46Y1WBF2Bq5SKtQDZ4kUb2fDCsbBs1THFWcV=8-OXh_SQ@mail.gmail.com>
Message-ID: <544A5459.9020006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.10.2014 15:23, Daniel Drake wrote:
> On Sun, Oct 19, 2014 at 9:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch adds new exynos4415.dtsi to support Exynos4415 SoC
>> based on Cortex-A9 quad cores and includes following dt nodes:
> 
> There's a lot in common between your new exynos4415.dtsi and the
> existing exynos4.dtsi.
> Would it make more sense for the 4415 code to extend the existing
> exynos4.dtsi like the other Exynos4 variants do?

This would make sense, but then existing Exynos 4 device tree sources
would have to be refactored to use reference-based syntax for extending
nodes. (Which is desirable anyway, but adds quite a bit of effort and
could be prone to conflicts.) I'd say that they could be merged later
anyway.

Best regards,
Tomasz
