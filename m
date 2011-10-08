From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 8 Oct 2011 21:02:19 +0800
Subject: [PATCH 08/26] ARM: pxa: move z2 to generic cpu_suspend
In-Reply-To: <14032344.tng7XWeaFg@wuerfel>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<201110071156.38283.arnd@arndb.de>
	<CAMPhdO97bJZ1FRHUq_VHQ8oHyY7U4ay-jv5Ft+gunRwtBvz8qw@mail.gmail.com>
	<14032344.tng7XWeaFg@wuerfel>
Message-ID: <CAMPhdO8D+faQksn79NBWMb_mdsAw0tSatvEL-zhN4jNjKm+trg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 8, 2011 at 9:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 08 October 2011 20:37:53 Eric Miao wrote:
>> >>
>> >> ?#ifdef CONFIG_PM
>> >> +extern void pxa27x_cpu_pm_enter(suspend_state_t state);
>> >> +
>> >> ?static void z2_power_off(void)
>> >> ?{
>> >> ? ? ? ? /* We're using deep sleep as poweroff, so clear PSPR to ensure that
>> >
>> > You really shouldn't have an extern declaration in a .c file. Otherwise
>> > looks good to me.
>>
>> How about this one?
>
> Yes, looks good as far as I can tell (I still don't quite understand how the
> cpu power management all fits together, but I don't see anything wrong with
> it either.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
