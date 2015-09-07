From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 7 Sep 2015 12:05:01 +0800
Subject: [PATCH 2/2] arm64: dts: mt8173: Add thermal zone node for mt8173.
In-Reply-To: <CAGS+omAxWDj+fHsJQhJ-KhFdWPZ-ymcVr63v5Q7ho2bAL_7PBQ@mail.gmail.com>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
 <1441357309-61669-3-git-send-email-dawei.chien@mediatek.com>
 <CAGS+omAxWDj+fHsJQhJ-KhFdWPZ-ymcVr63v5Q7ho2bAL_7PBQ@mail.gmail.com>
Message-ID: <CAGS+omDne19U+BzCQ8o9Hte=cDXNF3SL7zLE33UEFgWgMsPpOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 7, 2015 at 12:00 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi Dawei,
>
> On Fri, Sep 4, 2015 at 5:01 PM, Dawei Chien <dawei.chien@mediatek.com> wrote:
>> Add thermal zone node to mt8173.dtsi.
>>
>> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
>> ---
>> This patch is base on following patches
>> https://patchwork.kernel.org/patch/6969581/
>> https://patchwork.kernel.org/patch/6969571/
>> https://patchwork.kernel.org/patch/6969381/
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index 208051a..6493bfd 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -17,6 +17,7 @@
>>  #include <dt-bindings/power/mt8173-power.h>
>>  #include <dt-bindings/reset-controller/mt8173-resets.h>
>>  #include "mt8173-pinfunc.h"
>> +#include <dt-bindings/thermal/thermal.h>

Also, as a nit, (#include <dt-bindings/thermal/mt8173.h>) should be
above '#include "mt8173-pinfunc.h"'

-djk
