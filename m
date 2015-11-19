From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Nov 2015 18:44:57 +0100
Subject: [GIT PULL] at91: fixes for 4.4 #1
In-Reply-To: <5616576.CPP4uTUkOp@wuerfel>
References: <1447760158-20204-1-git-send-email-nicolas.ferre@atmel.com>
 <5616576.CPP4uTUkOp@wuerfel>
Message-ID: <564E0A99.9020707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/11/2015 16:22, Arnd Bergmann a ?crit :
> On Tuesday 17 November 2015 12:35:58 Nicolas Ferre wrote:
>> Arnd, Olof, Kevin,
>>
>> This is the first "fixes" pull-request for AT91. I tried to collect little
>> patches that didn't make it for -rc1.
>> It can be due to synchronization between trees like the addition of some
>> sama5d2 Xplained nodes (MFD tree) or the change of the watchdog compatible
>> string for sama5d4 (watchdog tree).
>> It can also be due to trivial cleanups that were spotted or submitted late like
>> the replacement of "wakeup" properties or removal of unneeded defconfig option.
>> The removal of some dead legacy DT properties or nodes is, in my opinion worth
>> it as well in order to prevent us from abusive cut'n paste.
>> NAND and ISI Atmel MAINTAINERS entries are also updated.
>>
>> Tell me if it's okay for you.
> 
> I'd be happier to get the patches late in the process and then push back
> myself than to get them as fixes, there was really no reason to wait
> for the merge window to end with the ones that you already had.

I thought than having a precise milestone as a base for this
pull-request would be preferred.

> None of the changes look too invasive for -rc2, so I'm taking it anyway,
> but please try to let us know what you have earlier next time, so we
> can get the first fixes into the merge window, or add them as late
> additions on the branches before sending the main pull requests.
> 
> Inter-tree dependencies should never be a reason to send stuff after
> -rc1, let's talk about that before the merge window if you know you
> have those.

Sure, the communication in advance with you would have make all this
easier, sorry for not having done this.

Thanks Arnd. Bye,
-- 
Nicolas Ferre
