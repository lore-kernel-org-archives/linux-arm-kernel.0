From: vkale@apm.com (Vinayak Kale)
Date: Sat, 20 Apr 2013 15:01:47 +0530
Subject: [PATCH 2/4] arm64: Initial defconfig for APM X-Gene SOC family
In-Reply-To: <2165570.9Zy5vrhoIa@wuerfel>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <1366442131-26094-3-git-send-email-vkale@apm.com>
 <2165570.9Zy5vrhoIa@wuerfel>
Message-ID: <CAPrCYkcc8owdKPUth2uDwugfjKV3i2MY9XHwbqCvn8UOL5s+6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 20, 2013 at 1:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 20 April 2013 12:45:29 Vinayak Kale wrote:
>> This patch adds initial defconfig for APM X-Gene SOC family.
>>
>> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  arch/arm64/configs/xgene_defconfig |   93 ++++++++++++++++++++++++++++++++++++
>>  1 files changed, 93 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm64/configs/xgene_defconfig
>
> Could you modify the regular defconfig to enable everything you need instead
> of adding another one? Since all the code is interoperable, I think we
> should not need a defconfig per soc.
Okay. What would be the good place to change CONFIG_NR_CPUS - a)
defcofig or b) arch/arch64/Kconfig?
Currently default value 4 is defined in Kconfig. I reckon this would
eventually be set to a highest number of CPUs implemented by a soc
among all the socs.
>
>         Arnd
Thanks
-Vinayak
