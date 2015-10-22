From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 22 Oct 2015 09:26:40 +0900
Subject: [PATCH 1/2] dt-bindings: Consolidate Exynos SoC bindings under
 Samsung directory
In-Reply-To: <CAL_JsqLhbqJOhQrGwg3CZ2Th+wgf3oMR6-2oNNZ98yHNjxsx_A@mail.gmail.com>
References: <1445391051-3727-1-git-send-email-k.kozlowski@samsung.com>
 <CAL_JsqLhbqJOhQrGwg3CZ2Th+wgf3oMR6-2oNNZ98yHNjxsx_A@mail.gmail.com>
Message-ID: <56282D40.2050504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.10.2015 09:22, Rob Herring wrote:
> On Tue, Oct 20, 2015 at 8:30 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> Exynos SoC Device Tree bindings are spread over arm/exynos/ and
>> arm/samsung/ directories. There is no need for that separation and it
>> actually confuses. Put everything under arm/samsung/.
> 
> Thanks for the clean-up.
> 
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> ---
>>  .../devicetree/bindings/arm/{exynos => samsung}/power_domain.txt          | 0
>>  Documentation/devicetree/bindings/arm/{ => samsung}/samsung-boards.txt    | 0
>>  Documentation/devicetree/bindings/arm/{exynos => samsung}/smp-sysram.txt  | 0
>>  3 files changed, 0 insertions(+), 0 deletions(-)
>>  rename Documentation/devicetree/bindings/arm/{exynos => samsung}/power_domain.txt (100%)
> 
> I'd rather see this with other power domain bindings. So
> bindings/power/pd-samsung.txt I guess.

OK

> 
>>  rename Documentation/devicetree/bindings/arm/{ => samsung}/samsung-boards.txt (100%)
>>  rename Documentation/devicetree/bindings/arm/{exynos => samsung}/smp-sysram.txt (100%)
> 
> Probably need to move misc/sram.txt to bindings/sram/ and put both there.

Right, that make sense. I'll send v2 moving pd-samsung and smp-sysram to
these locations.

Best regards,
Krzysztof
