From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Feb 2012 09:12:41 +0100
Subject: [PATCH] arch/arm/mach-ux500/board-mop500-u8500uib.c: included
 linux/gpio.h twice
In-Reply-To: <20120227072705.GA19429@bnru02>
References: <1329333578-31773-1-git-send-email-danny.kukawka@bisect.de>
 <20120227072705.GA19429@bnru02>
Message-ID: <CACRpkdYV-EoJNPei9JbM=xmF8i8J5sd33uE70cAMF7p-h42Zzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 8:27 AM, Srinidhi Kasagar
<srinidhi.kasagar@stericsson.com> wrote:
> On Wed, Feb 15, 2012 at 20:19:38 +0100, Danny Kukawka wrote:
>> arch/arm/mach-ux500/board-mop500-u8500uib.c included 'linux/gpio.h'
>> remove the duplicate.
>>
>> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
>> ---
>> ?arch/arm/mach-ux500/board-mop500-u8500uib.c | ? ?1 -
>> ?1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
>> index feb5744..ead91c9 100644
>> --- a/arch/arm/mach-ux500/board-mop500-u8500uib.c
>> +++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
>> @@ -8,7 +8,6 @@
>> ?#include <linux/kernel.h>
>> ?#include <linux/init.h>
>> ?#include <linux/i2c.h>
>> -#include <linux/gpio.h>
>> ?#include <linux/interrupt.h>
>> ?#include <linux/mfd/tc3589x.h>
>> ?#include <linux/input/matrix_keypad.h>
>
> Thanks,
>
> Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
>
> Linus W, would you please pick if you have not noticed this.

Thanks for the reminder, I've picked it up and merged
to my ux500-core branch.

Yours,
Linus Walleij
