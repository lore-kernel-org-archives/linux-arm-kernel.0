From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 27 Jul 2018 22:14:28 +0800
Subject: [PATCH v3 1/2] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <20180724232917.GA27041@rob-hp-laptop>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-2-yixun.lan@amlogic.com>
 <20180724232917.GA27041@rob-hp-laptop>
Message-ID: <e797412b-55db-6678-82ba-3a10ac99db9f@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


HI Rob

On 07/25/2018 07:29 AM, Rob Herring wrote:
> On Thu, Jul 12, 2018 at 09:12:43PM +0000, Yixun Lan wrote:
>> Document the MMC sub clock controller driver, the potential consumer
>> of this driver is MMC or NAND. Also add three clock bindings IDs which
>> provided by this driver.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
>>  .../clock/amlogic,meson-mmc-clkc.h            | 16 ++++++++++
>>  2 files changed, 47 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>  create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks for the review!

There is a discussion about dropping "meson-" prefix in the compatible
string[1]

So, I will send another version with the new compatible name adjusted
from "amlogic,meson-axg-mmc-clkc" to "amlogic,axg-mmc-clkc"..
probably also rename the dt-bindings header file to amlogc,mmc-clkc.h

[1]  https://lkml.kernel.org/r/7hk1prmg4w.fsf at baylibre.com


Yixun
