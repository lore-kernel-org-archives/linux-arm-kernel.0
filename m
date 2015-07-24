From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 24 Jul 2015 12:48:37 +0900
Subject: [PATCH v3 1/4] clk: samsung: exynos5250: add cpu clock
 configuration data and instantiate cpu clock
In-Reply-To: <20150724003918.642.78653@quantum>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
 <1435756238-845-2-git-send-email-b.zolnierkie@samsung.com>
 <20150724003918.642.78653@quantum>
Message-ID: <55B1B595.4040906@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/15 09:39, Michael Turquette wrote:
> Quoting Bartlomiej Zolnierkiewicz (2015-07-01 06:10:35)
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> With the addition of the new Samsung specific cpu-clock type, the
>> arm clock can be represented as a cpu-clock type. Add the CPU clock
>> configuration data and instantiate the CPU clock type for Exynos5250.
>>
>> Changes by Bartlomiej:
>> - split Exynos5250 support from the original patch
>> - moved E5250_CPU_DIV[0,1]() macros to clk-exynos5250.c
>>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Acked-by: Michael Turquette <mturquette@baylibre.com>
> 
Thanks, Mike.

> If Kukjin wants to merge this through the samsung tree then an immutable
> branch would be much appreciated.
> 
Here is the topic branch for clk tree and it will not be rebased.

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v4.3-topic/clk-samsung

If any problems, please kindly let me know.

Thanks,
Kukjin

> Regards,
> Mike
> 
>> ---
>>  drivers/clk/samsung/clk-exynos5250.c   | 31 +++++++++++++++++++++++++++++++
>>  include/dt-bindings/clock/exynos5250.h |  1 +
>>  2 files changed, 32 insertions(+)
