From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 17 Oct 2016 16:53:31 -0300
Subject: [PATCH] hwrng: meson: Fix module autoload for OF registration
In-Reply-To: <CAOMZO5B+iDyNJ-heFU2Th-HQHocLS3Lz5zV7hFhiLs7ESJt2gw@mail.gmail.com>
References: <1476733214-19044-1-git-send-email-javier@osg.samsung.com>
 <CAOMZO5B+iDyNJ-heFU2Th-HQHocLS3Lz5zV7hFhiLs7ESJt2gw@mail.gmail.com>
Message-ID: <82c306bc-4214-b923-ea45-f6358ed49722@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On 10/17/2016 04:45 PM, Fabio Estevam wrote:
> On Mon, Oct 17, 2016 at 5:40 PM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
> 
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -32,7 +32,7 @@ config TCG_TIS_CORE
>>
>>  config TCG_TIS
>>         tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface"
>> -       depends on X86
>> +       depends on X86 || COMPILE_TEST
> 
> This is a separate change.
> 

Yes, I did a commit by mistake. Sorry about that.

Jason already pointed out and I posted a v2.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
