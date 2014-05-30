From: t.dakhran@gmail.com (Tarek Dakhran)
Date: Fri, 30 May 2014 23:15:46 +0400
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <CAK9yfHwatFrQ9ssjJXi=eR3mz95xWQeRJ4-vkteR_Npksa3+tg@mail.gmail.com>
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <7hr43f9mmn.fsf@paris.lan> <538737CA.4070709@suse.de>
 <53874862.5080809@samsung.com> <538775AB.3000604@suse.de>
 <CAC5m3Bz53QO5tTTvk7qnBQtwtjMvSgYZ15prAvnLjdogQRsfMQ@mail.gmail.com>
 <CAK9yfHwatFrQ9ssjJXi=eR3mz95xWQeRJ4-vkteR_Npksa3+tg@mail.gmail.com>
Message-ID: <CANhyOUf0coACaziesgSXsL3Vy-sypxS_Eo=Cb-2OEAaBodep=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, May 30, 2014 at 10:16 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>
>
> On Friday, 30 May 2014, Tushar Behera <trblinux@gmail.com> wrote:
>>
>> On Thu, May 29, 2014 at 11:30 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> > Hi Tarek,
>> >
>> >
>> > And I reproducibly get failures for CPUs 1-3, resulting in only one CPU
>> > in /proc/cpuinfo (compared to 4 on downstream 3.14):
>> >
>> > [    0.045778] CPU: Testing write buffer coherency: ok
>> > [    0.045968] /cpus/cpu at 0 missing clock-frequency property
>> > [    0.045993] /cpus/cpu at 1 missing clock-frequency property
>> > [    0.046016] /cpus/cpu at 2 missing clock-frequency property
>> > [    0.046040] /cpus/cpu at 3 missing clock-frequency property
>> > [    0.046059] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> > [    0.046135] Setting up static identity map for 0x403a8920 -
>> > 0x403a8978
>> > [    2.075052] CPU1: failed to come online
>> > [    4.085095] CPU2: failed to come online
>> > [    6.095142] CPU3: failed to come online
>> > [    6.095237] Brought up 1 CPUs
>> > [    6.095269] SMP: Total of 1 processors activated.
>> > [    6.095303] CPU: All CPU(s) started in HYP mode.
>> > [    6.095336] CPU: Virtualization extensions available.
>> >
>> > I also notice another apparent device tree issue:
>> >
>> > [    7.341814] of_get_named_gpiod_flags: can't parse gpios property of
>> > node '/soc/mmc at 12220000/slot at 0[0]'
>> > [    7.341850] of_get_named_gpiod_flags: can't parse gpios property of
>> > node '/soc/mmc at 12220000/slot at 0[0]'
>> >
>> > Are any of those known issues and being worked on?
>> > (The CPU failures affected 5420 Arndale Octa as well iirc.)
>> >

[snip]

>>
>> [1] http://www.spinics.net/lists/linux-samsung-soc/msg31776.html
>>
>> [PATCH v2 Resend 1/2] ARM: EXYNOS: Update secondary boot addr for secure
>> mode
>>
>> [2] http://www.spinics.net/lists/linux-samsung-soc/msg31777.html
>>
>> [PATCH v2 Resend 2/2] ARM: dts: Add secure firmware support for
>> Arndale-octa
>>
>>
>> Kukjin,
>
> Can you please apply the above patches?
>

Patches [1], [2] tested on ODROID-XU, SMDK5410 and Arndale Octa boards.

Tested-by: Tarek Dakhran <t.dakhran@samsung.com>

Best regards,
     Tarek
