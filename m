From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Thu, 1 Oct 2015 14:31:22 +0530
Subject: Undefined instruction error on Cortex A57 (aarch64) in init
 process
In-Reply-To: <1631431.E7IDbh3b5M@wuerfel>
References: <CADTbHxpXCJZdK=iQc+FUxW27-vv1_kHXCeespDXR2fJ8UkfCCg@mail.gmail.com>
 <1631431.E7IDbh3b5M@wuerfel>
Message-ID: <CADTbHxpv1Aa50oSPyFVeghV6ikZ3qkX4L9R=1my9bj-uAfXZLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2015 at 2:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 01 October 2015 13:02:46 Pankaj Jangra wrote:
>> In android system, after system is running for long time say 10 hour,
>> some time i am hitting below
>> traces:
>>
>>  init[1]: undefined instruction: pc=0000000000401624
>> Code: 1a9f00c2 aa1703e0 2a1603e1 9400e1bf (6b1f001f)
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
>>
>>
>
> Is it always the same address that causes the invalid instruction?
> This is the main loop of the init process, so it clearly got executed
> correctly before.
>
>         Arnd

Yes Arnd, it always hits the same address. True, It must have been
executed lots of time.

-Pankaj Kumar
