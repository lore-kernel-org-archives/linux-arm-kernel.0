From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 14:43:05 +0100
Subject: [PATCH 0/4] ARM: at91: at91sam9x5: enable ISI and ov2640 support
In-Reply-To: <20150212100837.2ab78742@bbrezillon>
References: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
 <20150212100837.2ab78742@bbrezillon>
Message-ID: <54F70BE9.2030009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/02/2015 10:08, Boris Brezillon a ?crit :
> On Thu, 12 Feb 2015 16:06:22 +0800
> Josh Wu <josh.wu@atmel.com> wrote:
> 
>> This patch series will enable ISI and ov2640 sensor support for
>> at91sam9g25ek board.
> 
> This series looks good to me.
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


3 first patches stacked on top of at91-4.1-dt. Last one on
at91-4.1-defconfig.

Thank, bye.


>> Josh Wu (4):
>>   ARM: at91: at91sam9x5/dts: add ISI dt support, include isi node,
>>     pinctrls
>>   ARM: at91: at91sam9x5ek/dts: add ov2640 support
>>   ARM: at91: at91sam9g25ek/dts: enable ISI and ov2640
>>   ARM: at91: at91_dt_defconfig: enable ISI and ov2640 support
>>
>>  arch/arm/boot/dts/at91sam9g25.dtsi    |  1 +
>>  arch/arm/boot/dts/at91sam9g25ek.dts   | 18 +++++++++++++
>>  arch/arm/boot/dts/at91sam9x5_isi.dtsi | 46 +++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/at91sam9x5ek.dtsi   | 48 +++++++++++++++++++++++++++++++++++
>>  arch/arm/configs/at91_dt_defconfig    |  6 +++++
>>  5 files changed, 119 insertions(+)
>>
> 
> 
> 


-- 
Nicolas Ferre
