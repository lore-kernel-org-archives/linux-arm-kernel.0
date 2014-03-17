From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Mar 2014 07:20:56 +0900
Subject: [PATCH 2/2] dt-bindings: clock: Move exynos-audss-clk.h to
 dt-bindings/clock
In-Reply-To: <531D054E.70008@gmail.com>
References: <1394085884-13081-1-git-send-email-tushar.behera@linaro.org>
 <1394085884-13081-3-git-send-email-tushar.behera@linaro.org>
 <531D054E.70008@gmail.com>
Message-ID: <53277548.60300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/14 09:20, Tomasz Figa wrote:
> On 06.03.2014 07:04, Tushar Behera wrote:
>> Most of the clock related dt-binding header files are located in
>> dt-bindings/clock folder. It would be good to keep all the similar
>> header files at a single location.
>>
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>> CC: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Or shall I take this into samsung tree?

Thanks,
Kukjin

>> CC: Tomasz Figa <t.figa@samsung.com>
>> ---
>> arch/arm/boot/dts/exynos5250.dtsi | 2 +-
>> arch/arm/boot/dts/exynos5420.dtsi | 2 +-
>> drivers/clk/samsung/clk-exynos-audss.c | 2 +-
>> .../dt-bindings/{clk => clock}/exynos-audss-clk.h | 0
>> 4 files changed, 3 insertions(+), 3 deletions(-)
>> rename include/dt-bindings/{clk => clock}/exynos-audss-clk.h (100%)
>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
>
> Best regards,
> Tomasz
