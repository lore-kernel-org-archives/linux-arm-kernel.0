From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 15 Apr 2016 18:34:30 +0200
Subject: [PATCH v2 6/8] clk: samsung: exynos542x: Add the clock id for ACLK
In-Reply-To: <5710AEF2.3040800@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <1460701975-24178-7-git-send-email-cw00.choi@samsung.com>
 <5710AEF2.3040800@samsung.com>
Message-ID: <57111816.8080808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 11:05 AM, Krzysztof Kozlowski wrote:
> On 04/15/2016 08:32 AM, Chanwoo Choi wrote:
>> This patch adds the clock id for ACLK clock which is source clock of AMBA AXI
>> Bus. This clock should be handled in Bus frequency scaling driver.
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c | 77 ++++++++++++++++++++++--------------
>>  1 file changed, 47 insertions(+), 30 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I applied patches 5/8 and 6/8 onto a stable topic branch. Below are
details if they need to be pulled into any other subsystem tree.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.7-exynos542x

for you to fetch changes up to 81fed6e342c04a4ecb0650c914d24bd57c6c168f:

  clk: samsung: exynos542x: Add the clock id for ACLK (2016-04-15 18:13:45 +0200)

----------------------------------------------------------------
Addition of IDs for Exynos542x SoC AMBA AXI bus clocks.

----------------------------------------------------------------
Chanwoo Choi (2):
      dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
      clk: samsung: exynos542x: Add the clock id for ACLK

 drivers/clk/samsung/clk-exynos5420.c   | 77
+++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 include/dt-bindings/clock/exynos5420.h | 24 +++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 31 deletions(-)

-- 
Regards,
Sylwester
