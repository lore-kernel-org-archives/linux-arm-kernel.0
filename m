From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 14 Sep 2014 09:23:46 +0900
Subject: [PATCH V3] ARM: dts: Add DT changes for display on peach_pi
In-Reply-To: <CAEC9eQNSPKdTKbAnNpj1ssc==NHkLUUAb+02wZiO+v41XEvutQ@mail.gmail.com>
References: <1407145638-3803-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQNSPKdTKbAnNpj1ssc==NHkLUUAb+02wZiO+v41XEvutQ@mail.gmail.com>
Message-ID: <5414E012.3060701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/14 15:13, Ajay kumar wrote:
> On Mon, Aug 4, 2014 at 3:17 PM, Ajay Kumar<ajaykumar.rs@samsung.com>  wrote:
>> Add DT nodes for panel-simple "auo,b133htn01" panel.
>> Add backlight enable pin and backlight power supply for pwm-backlight.
>> Also, add panel phandle needed by dp to enable display on peach_pi.
>>
>> Signed-off-by: Ajay Kumar<ajaykumar.rs@samsung.com>
>> ---
>> Changes since V1:
>> Remove "simple-panel" compatible string and use only ""auo,b133htn01".
>>
>> Changes since V2:
>> As suggested by Andreas,
>> Use GPIO_ACTIVE_HIGH for backlight enable-gpios instead of using 0.
>> Change panel node naming from "panel-simple" to "panel".
>>
>>   arch/arm/boot/dts/exynos5800-peach-pi.dts |   27 ++++++++++-----------------
>>   1 file changed, 10 insertions(+), 17 deletions(-)
>>
Applied, thanks.

- Kukjin
