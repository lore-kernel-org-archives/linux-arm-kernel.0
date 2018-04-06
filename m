From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Apr 2018 15:54:35 +0200
Subject: [GIT PULL 3/3] ARM: SoC driver updates for 4.17
In-Reply-To: <CA+55aFzTKu8um8wu5EtZS83+vepPnGM9KG+fPZ91ZjTESOatYg@mail.gmail.com>
References: <CAK8P3a1rJc+3MMMwcYSZ0n14=5e_1v_UdnHexysuqy4RfQPxmA@mail.gmail.com>
 <CA+55aFzTKu8um8wu5EtZS83+vepPnGM9KG+fPZ91ZjTESOatYg@mail.gmail.com>
Message-ID: <CAK8P3a1gT=xzCrHQtPTn+ciqze2mArH07+FWEUtkfQgU_ohSjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2018 at 6:34 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 5, 2018 at 2:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> - the ARM CCN driver is moved out of drivers/bus into drivers/perf,
>>   which makes more sense. Similarly, the performance monitoring
>>   portion of the CCI driver are moved the same way and cleaned up
>>   a little more.
>
> This caused a trivial merge with the perf tree.
>
> But since I don't *build* the trivial merge resolution due to it being
> an arm-only file, I wanted to point it out.
>
> Because "not tested" very possibly means "I screwed something silly up
> and didn't notice".
>
> So as trivial as it seemed, it should still be checked.

Looks good to me and it survived the randconfig build tests,
so I assume it's fine.

       Arnd
