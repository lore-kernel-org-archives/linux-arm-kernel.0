From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 20 Nov 2014 21:45:29 +0100
Subject: [GIT PULL] ARM: BCM5301X: SoC changes for v3.19
In-Reply-To: <201411201027.22360.arnd@arndb.de>
References: <546298D9.7080800@hauke-m.de> <201411201027.22360.arnd@arndb.de>
Message-ID: <546E52E9.3040301@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2014 10:27 AM, Arnd Bergmann wrote:
> On Wednesday 12 November 2014, Hauke Mehrtens wrote:
>> ----------------------------------------------------------------
>> ARM: BCM5301X: SoC: two patches for the SoC part
>>
>> These patches were all send to the arm list and I haven't got any
>> negative responses.
>>
>> ----------------------------------------------------------------
>> Hauke Mehrtens (1):
>>       ARM: BCM5301X: fix early serial console
>>
>> Rafa? Mi?ecki (1):
>>       ARM: BCM5301X: select GPIOLIB as optional
> 
> Hi Hauke and Florian,
> 
> sorry for the late reply. The patches are both good and I want to merge them,
> but I have two problems with your pull request:
> 
> - I'm unsure about who is sending us patches for mach-bcm. I was under the
>   assumption that Florian would now handle all of them and pick up your
>   patches to forward them to arm at kernel.org together with the other mach-bcm
>   platforms. I'd much rather get only patches from one person per platform
>   directory, though we can have multiple people if that's what you all want.

I talked to Florian and he suggested me that I should send patches
directly to you. There could be some stuff shared with the other network
SoCs, there is nothing shared with the mobile SoCs.
We thought that it would be easier for us (Florian and me) if you pull
directly from me.

> - The pull request is based on -rc4, but I see no strong reason why you did
>   that. It helps us a lot of all pull requests in a branch are based off
>   the same -rc, so please have them based on -rc1 by default or explain why
>   you picked something else in the tag description.

I just thought that I should base it on a recent -rc, so I took -rc4, I
can rebase it on rc1 if you like, I do not depend on any new stuff.

> If you want, I can just cherry-pick the two patches from your branch into
> the next/soc branch so you don't have to rebase it this time.

That would be nice.

Hauke
