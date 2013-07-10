From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 10 Jul 2013 11:12:25 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 arch timer frequency update
In-Reply-To: <20130710012346.GT32603@verge.net.au>
References: <20130709125007.4388.15701.sendpatchset@w520>
 <20130710012346.GT32603@verge.net.au>
Message-ID: <CANqRtoSHk_LJ6AyFqHYPy6w-As3XN=3Peku08gDMoEcz5MoRHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 10:23 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jul 09, 2013 at 09:50:07PM +0900, Magnus Damm wrote:
>> ARM: shmobile: r8a7790 arch timer frequency update
>>
>> [PATCH 01/02] ARM: shmobile: Introduce r8a7790_read_mode_pins()
>> [PATCH 02/02] ARM: shmobile: Setup r8a7790 arch timer based on MD pins
>>
>> Add code to setup r8a7790 arch timer frequency dynamically at boot time
>> based on the EXTAL frequency pointed out by the boot mode pins.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>>  Built on top of renesas-next-20130704v2
>>
>>  arch/arm/mach-shmobile/clock-r8a7790.c        |   11 ----
>>  arch/arm/mach-shmobile/include/mach/r8a7790.h |    3 +
>>  arch/arm/mach-shmobile/setup-r8a7790.c        |   63 +++++++++++++++++++++++--
>>  3 files changed, 63 insertions(+), 14 deletions(-)
>
> Hi Magnus,

Hi Simon,

Thanks for your help picking up patches.

> could you please let me know if/when these patches are ready to queue-up
> for v3.12?

There are two things to consider:
1) Patch 1/2 needs to be updated to handle feedback from Sergei.
2) I'd like the series to be tested by Ulrich to see if they actually help!

I can resend 1/2 today or tomorrow and I think Ulrich can most likely
help us with testing sometime this week.

Cheers,

/ magnus
