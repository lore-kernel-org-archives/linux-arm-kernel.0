From: olof@lixom.net (Olof Johansson)
Date: Mon, 30 Jun 2014 20:31:28 -0700
Subject: [GIT PULL] the great <mach/gpio.h> purge
In-Reply-To: <02c501cf94d1$fca59720$f5f0c560$@samsung.com>
References: <CACRpkdbPHn6bWdr8t9BrmE2JZZuuVnF7ujzEFdrM86WmrRS5Hw@mail.gmail.com>
 <02c501cf94d1$fca59720$f5f0c560$@samsung.com>
Message-ID: <CAOesGMgkG_LJR2Db6+S339SYpaf+0cBxs2oXNOAHiq4-J3H0pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 7:13 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Linus Walleij wrote:
>>
>> Hi ARM SoC guys,
>>
> Hi Linus,
>
>> please pull in this patch set removing <mach/gpio.h> for good.
>> I guess it could collide with some S5P deletion.
>
> Yeah...
>
>> If you decide to pull the S5P purge first, tell me so I can rebase.
>>
> So, I think, would be better if we could remove S5P64X0 and S5PC100 then
> <mach/gpio.h> in samsung stuff. But it's up to arm-soc maintainer? ;-)


As long as it's just deletion from both sides, I can happily resolve
that when merging.

Kukjin, I presume the removal would be in a cleanup branch as well?
Please try to send it soon so we can get some time in -next with it.

(I'll do merges in a couple of days, the backlog is building up. :)


-Olof
