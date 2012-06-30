From: olof@lixom.net (Olof Johansson)
Date: Sat, 30 Jun 2012 16:29:27 -0700
Subject: [GIT PULL]
In-Reply-To: <4FDF9419.2090601@antcom.de>
References: <4FDF9419.2090601@antcom.de>
Message-ID: <CAOesGMhbRnU3wExk88Wkc2=YwbuNpt_uPEsAfmZh6_os9CkqiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 18, 2012 at 1:48 PM, Roland Stigge <stigge@antcom.de> wrote:
> Hi Arnd and Olof,
>
> this is the pull request for the 22 patches we discussed last week, still same
> commits in the same branch (the 23rd patch was removed from the series, as
> discussed on the list).
>
> This time, purely mach-lpc32xx specific patches.
>
> Please tell if sth. is missing, so I can know if I can build upon that. (I'm
> already collecting new patches on top of this branch.)

I'm very sorry for the slow response to this pull request.

The contents of it in itself looks good, but given the amount of
patches that you are building up now, I think it's time to start
organizing into topic branches that fit the structure of arm-soc a bit
better.

In other words, it makes sense to separate out things such as dts
updates in their own branch, core SoC updates in one, etc.

Given that you've based other work on top of this combined branch now,
and the fact that I should have gotten back to you sooner about it,
I'm going to pull it in under our next/soc branch this time. But I'd
like to see more topic-oriented pull requests in the future, ideally
for your updates here but definitely in the branches you stage for
3.7.

Let me know if you have any questions, or if there's something we
should explain a bit better about how we organize the branches.

> git://git.antcom.de/linux-2.6.git lpc32xx-next

Pulled as lpc32xx/devel and merged into next/soc. You can still use
this branch as a base for more fine-grained topic branches, we should
be able to deal with those dependencies in arm-soc.


Thanks,

-Olof
