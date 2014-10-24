From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 24 Oct 2014 22:53:50 +0900
Subject: [PATCH 5/5] ARM: dts: Add dts files for Exynos4415 SoC
In-Reply-To: <CAD8Lp46Y1WBF2Bq5SKtQDZ4kUb2fDCsbBs1THFWcV=8-OXh_SQ@mail.gmail.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>
 <1413775935-17743-5-git-send-email-cw00.choi@samsung.com>
 <CAD8Lp46Y1WBF2Bq5SKtQDZ4kUb2fDCsbBs1THFWcV=8-OXh_SQ@mail.gmail.com>
Message-ID: <544A59EE.7010300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 10/24/2014 10:23 PM, Daniel Drake wrote:
> On Sun, Oct 19, 2014 at 9:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch adds new exynos4415.dtsi to support Exynos4415 SoC
>> based on Cortex-A9 quad cores and includes following dt nodes:
> 
> There's a lot in common between your new exynos4415.dtsi and the
> existing exynos4.dtsi.
> Would it make more sense for the 4415 code to extend the existing
> exynos4.dtsi like the other Exynos4 variants do?

I explained the difference between Exynos4415 and existing Exynos4 series
on mail-thread of exynos4415 clock controller.

Exynos4415 has difference clock id from existing Exynos4 clock controller.
because exynos4415 clock controller has fewer difference from Exynos4 series.

Best Regards,
Chanwoo Choi
