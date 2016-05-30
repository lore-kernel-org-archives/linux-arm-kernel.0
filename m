From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 30 May 2016 17:27:14 +0200
Subject: [PATCH v5 00/22] ARM: dts: exynos: Add initial support for Odroid
 XU
In-Reply-To: <1464429273-23457-1-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
Message-ID: <574C5BD2.60008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2016 11:54 AM, Krzysztof Kozlowski wrote:
>
> The clock changes can go to clock tree. ARM changes to samsung-soc tree.
> Please provide me a tag with include/dt-bindings/clock commits so I can
> merge it.

I applied the clock tree patches and here is the tag for the three
include/dt-bindings patches:

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.8-exynos5410-dt

for you to fetch changes up to ed1e1505db0c116affdfab01e650c44a9c459c65:

  dt-bindings: clock: Add I2C, HSI2C and RTC clock IDs to Exynos5410
(2016-05-30 16:00:11 +0200)

----------------------------------------------------------------
Adition of missing clock index definitions for exynos5410 SoC
PWM, USB, I2C, and RTC device related clocks.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      dt-bindings: clock: Add license and reformat Exynos5410 clock IDs
      dt-bindings: clock: Add PWM and USB clock IDs to Exynos5410
      dt-bindings: clock: Add I2C, HSI2C and RTC clock IDs to Exynos5410

 include/dt-bindings/clock/exynos5410.h | 73
+++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 22 deletions(-)


--
Thanks,
Sylwester
