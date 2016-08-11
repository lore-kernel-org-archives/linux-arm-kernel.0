From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 11 Aug 2016 10:23:31 -0700
Subject: [PATCH 1/1] ARM: dts: imx6q-evi: Use GPIO_6 for fec irq
In-Reply-To: <745430359.250170.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
References: <1470934446-22536-1-git-send-email-stillcompiling@gmail.com>
 <745430359.250170.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
Message-ID: <57ACB493.4040809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan,

On 08/11/2016 10:09 AM, Stefan Wahren wrote:
> Hi Joshua,
>
>> Joshua Clayton <stillcompiling@gmail.com> hat am 11. August 2016 um 18:54
>> geschrieben:
>>
>>
>> Apply hardware workaround for ethernet problem
>> See nxp erratum err006687
> do you know this commit?
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=a28eeb43ee57e0524c59e64760ed28088dd159cb
>
> Maybe you want to add this property, too.
I missed that this change requiring (more) explicit enablement was merge to linux-next.
I'll add that.
