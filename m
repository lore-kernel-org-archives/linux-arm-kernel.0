From: stigge@antcom.de (Roland Stigge)
Date: Sun, 01 Jul 2012 17:40:44 +0200
Subject: [GIT PULL]
In-Reply-To: <CAOesGMhbRnU3wExk88Wkc2=YwbuNpt_uPEsAfmZh6_os9CkqiA@mail.gmail.com>
References: <4FDF9419.2090601@antcom.de>
 <CAOesGMhbRnU3wExk88Wkc2=YwbuNpt_uPEsAfmZh6_os9CkqiA@mail.gmail.com>
Message-ID: <4FF06F7C.8050701@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/07/12 01:29, Olof Johansson wrote:
>> This time, purely mach-lpc32xx specific patches.
>>
>> Please tell if sth. is missing, so I can know if I can build upon that. (I'm
>> already collecting new patches on top of this branch.)
> 
> I'm very sorry for the slow response to this pull request.
> 
> The contents of it in itself looks good, but given the amount of
> patches that you are building up now, I think it's time to start
> organizing into topic branches that fit the structure of arm-soc a bit
> better.
> 
> In other words, it makes sense to separate out things such as dts
> updates in their own branch, core SoC updates in one, etc.
> 
> Given that you've based other work on top of this combined branch now,
> and the fact that I should have gotten back to you sooner about it,
> I'm going to pull it in under our next/soc branch this time. But I'd
> like to see more topic-oriented pull requests in the future, ideally
> for your updates here but definitely in the branches you stage for
> 3.7.

I'm fine with this.

Building upon the branch you just pulled, I'll separate out the further
patches into topic branches. Is there a certain set of those which I
should use to adjust to arm-soc structure? E.g.:

lpc32xx/core
lpc32xx/defconfig
lpc32xx/dts

?

Thanks for pointing this out!

Roland
