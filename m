From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 04 Jan 2013 18:37:26 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <20130104183139.20492204@skate>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch> <20130104183139.20492204@skate>
Message-ID: <50E71356.3030203@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/13 18:31, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
>
> On Fri, 04 Jan 2013 18:26:35 +0100, Andrew Lunn wrote:
>
>> How many different boards have you tried?
>
> I've tried only one board, since I have only one.
>
>> I've not had problems with the board i have. Using the plathome supplied
>> kernel, i've rebuilt the kernel, which is a good memory test. Using
>> mainline, i've booted a number of times when developing the thermal
>> driver and not had problems.
>>
>> I would hate to disable 2GB of RAM just because your board has a fault.
>
> Indeed. If you report that things work nicely on your board, then let's
> discard this fix, and blame a hardware problem.

Hi Thomas

It would be nice to have a sample size bigger than two.

Anybody else have a OpenBlocks AX3-4 and can report if it works or not?

Thomas, could you swap out the RAM module you have for a known good one?
Can you test the RAM module in some other board you know works?

Thanks
     Andrew
