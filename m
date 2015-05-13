From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 13 May 2015 16:00:21 +0900
Subject: [PATCH v7 0/4] ARM: SoC: add a new platform,
 UniPhier (arch/arm/mach-uniphier)
In-Reply-To: <2101307.fSn8Z2ZyBq@wuerfel>
References: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
 <2101307.fSn8Z2ZyBq@wuerfel>
Message-ID: <CAK7LNASyJmyUcKNecdhWjXbd615=9XcMxeLxC7y_z+psO03BbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2015-05-13 0:00 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 08 May 2015 13:07:10 Masahiro Yamada wrote:
>> This is an initial series for supporting Socionext UniPhier SoCs,
>> based on ARM Cortex-A9, mainly used for digital TVs, video recorders, etc.
>>
>>
>> Masahiro Yamada (4):
>>   ARM: UniPhier: add basic support for UniPhier architecture
>>   ARM: multi_v7_defconfig: enable UniPhier SoC family
>>   ARM: dts: UniPhier: add support for UniPhier SoCs and boards
>>   MAINTAINERS: add myself as ARM/UniPhier maintainer
>
> Applied all four patches, to the next/soc, next/defconfig, next/dt and
> next/soc branches respectively.

Thanks!
I can see them.


> Welcome as our latest new maintainer. In the future, please send
> any follow-up patches for the architecture specific code to
> arm at kernel.org in addition to the normal recipients, once you
> consider them ready to be applied.


Please teach me a little more because I am not experienced enough
in this community.


I checked MAINTAINERS, but I could not find arm at kernel.org.
Is it documented somewhere?

I found ARM SUB-ARCHITECTURES entry in that file, but it does not mention
the responsible individuals.
(I assume, you and Olof are the ones.)


ARM SUB-ARCHITECTURES
L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      arch/arm/mach-*/
F:      arch/arm/plat-*/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git



I have one more question.

Are you receiving pull requests from each sub-arch maintainer?
Or should every patch be submitted to arm at kernel.org and
applied by you (or other ARM-SoC maintainers)?

I have not earned enough reputations in this ML, so I know
it is too early for me to handle pull-reqs.

I understand the general development process of Linux, but
the maintainership of the ARM-SoC subsystem looks more hierarchized, so
I just want to know its development process correctly.


-- 
Best Regards
Masahiro Yamada
