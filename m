From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Wed, 31 Oct 2012 12:44:59 +0900
Subject: [PATCH] i2c: mv64xxx: Add support Armada-XP SoC
In-Reply-To: <508FF72B.5080708@mvista.com>
References: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org>
 <508FF72B.5080708@mvista.com>
Message-ID: <CABMQnVLAOm3JEynXqPD+zL-D02i2bDJRV3JbOfBKLX7PzEGbsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 31, 2012 at 12:50 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 10/30/2012 01:39 PM, Nobuhiro Iwamatsu wrote:
>
>> The Armada-XP SoC has the same I2C controller as mv64xxxi-i2c.
>> This validates to use mv64xxx in this SoC.
>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> ---
>>  drivers/i2c/busses/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 65dd599..ff53cf4 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -474,7 +474,7 @@ config I2C_MPC
>>
>>  config I2C_MV64XXX
>>       tristate "Marvell mv64xxx I2C Controller"
>> -     depends on (MV64X60 || PLAT_ORION)
>> +     depends on (MV64X60 || PLAT_ORION || MACH_ARMADA_370_XP)
>
>   Could remove useless parens, while at it...
>
OK, I will send a patch which revise about this.

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
