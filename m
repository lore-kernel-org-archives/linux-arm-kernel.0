From: khilman@ti.com (Kevin Hilman)
Date: Mon, 30 Apr 2012 10:20:27 -0700
Subject: [PATCH/RFT 6/8] ARM: OMAP: remove unused cpu_is_omap3505()
In-Reply-To: <CAORVsuVYXooj5CPzZZhOL8asmoX5X1bB=D-7pyf4McgKOATmyg@mail.gmail.com>
 (Jean Pihet's message of "Mon, 30 Apr 2012 11:07:16 +0200")
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
 <1335482993-14035-7-git-send-email-khilman@ti.com>
 <CAORVsuVYXooj5CPzZZhOL8asmoX5X1bB=D-7pyf4McgKOATmyg@mail.gmail.com>
Message-ID: <87y5pduof8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Kevin,
>
> On Fri, Apr 27, 2012 at 1:29 AM, Kevin Hilman <khilman@ti.com> wrote:
>> The 3505 check is now unused and can be removed.
>>
>> There are no longer any cpu_is_* checks that depend on specific IP
>> detection.
>>
>> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> ?arch/arm/plat-omap/include/plat/cpu.h | ? ?8 +-------
>> ?1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>> index 41f3e5a..b34bf6c 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -250,8 +250,7 @@ IS_AM_SUBCLASS(335x, 0x335)
>> ?* cpu_is_omap2423(): ?True for OMAP2423
>> ?* cpu_is_omap2430(): ?True for OMAP2430
>> ?* cpu_is_omap3430(): ?True for OMAP3430
>> - * cpu_is_omap3505(): ?True for OMAP3505
>> - * cpu_is_omap3517(): ?True for OMAP3517
>> + * cpu_is_omap3517(): ?True for AM35x: OMAP3517, OMAP3505
> Is cpu_is_omap35xx() a better name for it?

Later in the series, it is renamed to cpu_is_am35xx().

Kevin
