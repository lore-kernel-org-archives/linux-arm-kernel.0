From: cjb@laptop.org (Chris Ball)
Date: Sat, 11 Feb 2012 16:26:59 -0500
Subject: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft reset
 is performed
In-Reply-To: <4F338C6F.9030802@atmel.com> (Nicolas Ferre's message of "Thu, 09
 Feb 2012 10:05:51 +0100")
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
 <1328784929-24174-1-git-send-email-ludovic.desroches@atmel.com>
 <4F338C6F.9030802@atmel.com>
Message-ID: <m2ipjdkqn0.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 09 2012, Nicolas Ferre wrote:
> On 02/09/2012 11:55 AM, ludovic.desroches at atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>> 
>> Sometimes a software reset is needed. Then some registers are saved and
>> restored but the interrupt mask register is missing. It causes issues
>> with sdio devices whose interrupts are masked after reset.
>> 
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Chris, can you please queue this patch in a "fixes" branch?

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
