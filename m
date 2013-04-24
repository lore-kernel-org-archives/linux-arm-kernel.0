From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 24 Apr 2013 11:36:33 +0200
Subject: [PATCH v3 1/2] ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM
In-Reply-To: <20130424074904.GG847@verge.net.au>
References: <1366196190-14011-1-git-send-email-hechtb+renesas@gmail.com>
 <20130424074904.GG847@verge.net.au>
Message-ID: <CABYn4swtOdJG18833FLXifeuVsL4R5vUzGjAg5Fv8r==CT5HBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/24 Simon Horman <horms@verge.net.au>:
> On Wed, Apr 17, 2013 at 12:56:29PM +0200, Bastian Hecht wrote:
>> We add 2 Suspend to RAM modes:
>> - A3SM PLL0 on/off:     Power domain A3SM that contains the ARM core
>>                         and the 2nd level cache with either PLL0 on
>>                         or off
>>
>> As the suspend to memory mechanism we use A3SM PLL off. A3SM PLL on
>> is included here too, so CPUIdle can use both power down modes (not
>> included in this patch).
>>
>> The setup of the SYSC regarding the external IRQs is taken from
>> pm-sh7372.c from Magnus Damm.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>> v3:
>>
>> We now stubbornly loop until the SoC really shuts down when we issue
>> the WFI command.
>
> Hi Bastian,
>
> could you let me know what the status of this series is.
> Is it ready to be queued-up for v3.11?

Hello Simon!

I consider it stable and as there are no more comments, I would be
happy if you queued it up.

Thanks,

Bastian
