From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Nov 2013 17:40:37 +0900
Subject: [PATCH] ARM: shmobile: lager: mark GPIO keys as wake-up sources
In-Reply-To: <20131114062639.GA2292@verge.net.au>
References: <20131113224026.20904.35898.sendpatchset@w520>
 <20131114062639.GA2292@verge.net.au>
Message-ID: <CANqRtoQtEUubECP9gtXtEnazrHzaABpG4pmVKenRr4Yh5t76WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Nov 14, 2013 at 3:26 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Nov 14, 2013 at 07:40:26AM +0900, Magnus Damm wrote:
>> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>
>> Enable wakeup for the GPIO keys on the Lager board.
>>
>> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Hi Magnus,
>
> is this relevant to other boards too?

Yes, but I'd like to add the missing pieces for Suspend-to-RAM to
other SoCs too before trying to do that. If you want to give it a go,
why don't you try to enable it on r8a7779 and Marzen?

Thanks,

/ magnus
