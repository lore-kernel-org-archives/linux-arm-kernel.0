From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 17 Aug 2016 16:37:18 +0900
Subject: [PATCH 7/7] arm64: dts: exynos: Add dts file for Exynos5433-based
 TM2E board
In-Reply-To: <66f412cc-edc6-29f9-bc50-3f3d8eb69bf4@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471329328-26842-3-git-send-email-cw00.choi@samsung.com>
 <CGME20160817064349epcas1p1d0b6da0e0e87788868bfcd63bfa92cf6@epcas1p1.samsung.com>
 <66f412cc-edc6-29f9-bc50-3f3d8eb69bf4@samsung.com>
Message-ID: <57B4142E.30000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2016? 08? 17? 15:43, Krzysztof Kozlowski wrote:
> On 08/16/2016 08:35 AM, Chanwoo Choi wrote:
>> This patcha adds the Device Tree source for Exynos5433-based Samsung TM2E
> 
> s/patcha/patch/

OK.

> 
>> board. TM2E board is the most similiar with TM2 board. The exynos5433-tm2e.dts
> 
> s/similiar/similar/

OK.

> 
>> include the difference between TM2 and TM2E.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
>> Signed-off-by: Inha Song <ideal.song@samsung.com>
>> Signed-off-by: Ingi kim <ingi2.kim@samsung.com>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  .../bindings/arm/samsung/samsung-boards.txt        |  1 +
>>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     | 41 ++++++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> index c704b4bf6137..c1bda8d3674c 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> @@ -16,6 +16,7 @@ Required root node properties:
>>  	- "samsung,smdk5410"	- for Exynos5410-based Samsung SMDK5410 eval board.
>>  	- "samsung,smdk5420"	- for Exynos5420-based Samsung SMDK5420 eval board.
>>  	- "samsung,tm2"		- for Exynos5333-based Samsung TM2 board.
>> +	- "samsung,tm2e"	- for Exynos5333-based Samsung TM2E board.
>>  	- "samsung,sd5v1"	- for Exynos5440-based Samsung board.
>>  	- "samsung,ssdk5440"	- for Exynos5440-based Samsung board.
>>  
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
>> new file mode 100644
>> index 000000000000..283b4fd19d5a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
>> @@ -0,0 +1,41 @@
>> +/*
>> + * SAMSUNG Exynos5433 TM2E board device tree source
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *
>> + * Device tree source file for Samsung's TM2E(TM2 EDGE) board which is based on
>> + * Samsung Exynos5433 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "exynos5433-tm2.dts"
>> +
> 
> Cool!
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks for the review.

Best regards,
Chanwoo Choi
