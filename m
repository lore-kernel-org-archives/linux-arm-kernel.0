From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 06 Jun 2016 13:02:41 +0200
Subject: [PATCH 2/3] clk: samsung: exynos5410: Add WDT,
 ACLK266 and SSS clocks
In-Reply-To: <1464774351-23604-2-git-send-email-k.kozlowski@samsung.com>
References: <1464774351-23604-1-git-send-email-k.kozlowski@samsung.com>
 <1464774351-23604-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <57555851.6020206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 11:45 AM, Krzysztof Kozlowski wrote:
> Add clock hierarchy for Security SubSystem clock and watchdog.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

A applied patches: 

[PATCH 1/3] dt-bindings: clock: Add watchdog and SSS clock IDs to Exynos5410
[PATCH 2/3] clk: samsung: exynos5410: Add WDT, ACLK266 and SSS clocks

[PATCH 1/6] dt-bindings: clock: Add TMU clock ID to Exynos5410
[PATCH 2/6] clk: samsung: exynos5410: Add TMU clock

And here is a subsequent tag from a stable branch including all 
the dependency "dt-bindings" patches:

------8<------
The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.8-exynos5410-dt-2

for you to fetch changes up to 4528dd8ed477bf202bd33ee48d38d656672d37f8:

  dt-bindings: clock: Add watchdog and SSS clock IDs to Exynos5410 (2016-06-02 11:17:55 +0200)

----------------------------------------------------------------
Adition of missing clock index definitions for exynos5410 SoC:
PWM, USB, I2C, RTC, PMU, watchdog and the security device related
clocks.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      dt-bindings: clock: Add license and reformat Exynos5410 clock IDs
      dt-bindings: clock: Add PWM and USB clock IDs to Exynos5410
      dt-bindings: clock: Add I2C, HSI2C and RTC clock IDs to Exynos5410
      dt-bindings: clock: Add TMU clock ID to Exynos5410
      dt-bindings: clock: Add watchdog and SSS clock IDs to Exynos5410

 include/dt-bindings/clock/exynos5410.h | 76 +++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 22 deletions(-)
------8<------

--
Thanks, 
Sylwester
