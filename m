From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 02 Jun 2015 21:46:31 +0900
Subject: [PATCH v4 3/5] pinctrl: exynos: add exynos5410 SoC specific data
In-Reply-To: <CA+Ln22Fq6Z6vSy2zCsx61j-JVe_x=yAjkySXy_Lit0tBbPmo9Q@mail.gmail.com>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
 <1426456834-6308-4-git-send-email-afaerber@suse.de>
 <CA+Ln22Fq6Z6vSy2zCsx61j-JVe_x=yAjkySXy_Lit0tBbPmo9Q@mail.gmail.com>
Message-ID: <556DA5A7.4080502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 24.03.2015 o 02:22, Tomasz Figa pisze:
> Hi Andreas, Hakjoo,
> 
> Thanks for the patch.
> 
> 2015-03-16 7:00 GMT+09:00 Andreas F?rber <afaerber@suse.de>:
>> From: Hakjoo Kim <ruppi.kim@hardkernel.com>
>>
>> Add Samsung EXYNOS5410 SoC specific data to enable pinctrl
>> support for all platforms based on EXYNOS5410.
>>
>> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
>> [AF: Rebased onto Exynos5260, irq_chip consolidation, const'ification]
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v2 -> v3:
>>  * Rebased (.svc, .{g,w}eint_{con,mask,pend} fields dropped)
>>
>>  v1 -> v2:
>>  * Filled in Sob from Hakjoo Kim
>>
>>  .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
>>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 103 +++++++++++++++++++++
>>  drivers/pinctrl/samsung/pinctrl-samsung.c          |   2 +
>>  drivers/pinctrl/samsung/pinctrl-samsung.h          |   1 +
>>  4 files changed, 107 insertions(+)
>>
> 
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

So I assume this may go through Kukjin tree.

Best regards,
Krzysztof
