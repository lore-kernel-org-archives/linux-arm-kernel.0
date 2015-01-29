From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 15:06:12 -0800
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #4
In-Reply-To: <20150129230157.GD4164@piout.net>
References: <1422532272-32055-1-git-send-email-nicolas.ferre@atmel.com>
 <20150129220256.GG20785@quad.lixom.net>
 <CAOesGMjf6mPhq3s9jf+kTvKFkYM+yLdZ7akLQM_q_TCj3qHF3g@mail.gmail.com>
 <20150129230157.GD4164@piout.net>
Message-ID: <CAOesGMhycUD4ZfQccjD=zzRB901u0YT1NqCuA7chNTnvgt7Fsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 3:01 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 29/01/2015 at 14:08:25 -0800, Olof Johansson wrote :
>> On Thu, Jan 29, 2015 at 2:02 PM, Olof Johansson <olof@lixom.net> wrote:
>> > On Thu, Jan 29, 2015 at 12:51:12PM +0100, Nicolas Ferre wrote:
>> >> Arnd, Olof, Kevin,
>> >>
>> >> This is a batch of cleanup/soc modifications that you may also stack on top of
>> >> your "soc" branch as the previous one.
>> >> It collects some more cleanup material and simplifies the AT91 boot code. Only
>> >> some little details remain before having a classical DT boot (without additional
>> >> mapping of registers for instance). This part will be addressed in 3.21.
>> >>
>> >> The switch to multi-platform is not included as it needs some patches in ASoC,
>> >> ata and arm-soc/next/drivers to be able to compile. I may send patches or a
>> >> pull-request that can be send to Linus late during the merge-window. Tell me
>> >> how you feel it can be done (or delayed to 3.21).
>> >>
>> >> The conflict related to the rename of board-dt-sama5.c => sama5.c is solved in
>> >> this branch:
>> >> https://git.kernel.org/cgit/linux/kernel/git/nferre/linux-at91.git/log/?h=arm-soc-for-next%2bat91-3.20-cleanup
>> >>
>
> The conflict is fixed there ;)

This conflict will bubble all the way up to Linus. I wonder if it's
better to just include the fix as a base of this branch. Not merged on
top, but as a base. That'll be easiest of all.

Nicolas, can you respin with that as base? Since that fixes branch
from you is based on -rc1, it should work out quite well.



-Olof
