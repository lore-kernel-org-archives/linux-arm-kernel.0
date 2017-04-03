From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 4 Apr 2017 00:05:10 +0300
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
 <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
 <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
Message-ID: <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Cc: Tom

Summon Tom to the discussion. He tried once hard to shrink a Linux
kernel to something working in 1M+ RAM on x86.

Tom, sorry, I recall this a bit late, perhaps you might be interested
in reading discussion from the beginning.

On Mon, Apr 3, 2017 at 9:14 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 3, 2017 at 12:44 AM, Stuart Longland
> <stuartl@longlandclan.id.au> wrote:
>> On 03/04/17 07:41, Nicolas Pitre wrote:
>>>> No PTYs seems like a big limitation. This means no sshd?
>>> Again, my ultimate system target is in the sub-megabyte of RAM.  I
>>> really doubt you'll be able to fit an SSH server in there even if PTYs
>>> were supported, unless sshd (or dropbear) can be made really tiny.
>>> Otherwise you most probably have sufficient resources to run the regular
>>> TTY code.
>>
>> Are we talking small microcontrollers here?  The smallest machine in
>> terms of RAM I ever recall running Linux on was a 386SX/25 MHz with 4MB
>> RAM, and that had a MMU.
>
> Let's halve that. I once tried and ran Linux in 2 MiB, incl. X, twm, and xterm.
> Of course with swap enabled.  And swapping like hell.


-- 
With Best Regards,
Andy Shevchenko
