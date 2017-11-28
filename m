From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 29 Nov 2017 07:16:52 +0800
Subject: [PATCH v3 2/3] clk: meson-axg: add clock controller drivers
In-Reply-To: <20171128163022.7b7wvfqedkhhnaj6@rob-hp-laptop>
References: <20171128125330.363-1-yixun.lan@amlogic.com>
 <20171128125330.363-3-yixun.lan@amlogic.com>
 <20171128163022.7b7wvfqedkhhnaj6@rob-hp-laptop>
Message-ID: <1811d609-36bc-290c-6405-80121e4de8bb@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



HI Rob

On 11/29/17 00:30, Rob Herring wrote:
> On Tue, Nov 28, 2017 at 08:53:29PM +0800, Yixun Lan wrote:
>> From: Qiufang Dai <qiufang.dai@amlogic.com>
>>
>> Add clock controller drivers for Amlogic Meson-AXG SoC.
>>
>> Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  arch/arm64/Kconfig.platforms         |   1 +
>>  drivers/clk/meson/Kconfig            |   8 +
>>  drivers/clk/meson/Makefile           |   1 +
>>  drivers/clk/meson/axg.c              | 948 +++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/axg.h              | 126 +++++
> 
>>  include/dt-bindings/clock/axg-clkc.h |  72 +++
> 
> This belongs in the binding patch.
> 
is it Ok to keep it in this patch?
the initial idea to do this is to keep the commit bisectable..

> Otherwise, 
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> 
>>  6 files changed, 1156 insertions(+)
>>  create mode 100644 drivers/clk/meson/axg.c
>>  create mode 100644 drivers/clk/meson/axg.h
>>  create mode 100644 include/dt-bindings/clock/axg-clkc.h
> 
> .
> 
