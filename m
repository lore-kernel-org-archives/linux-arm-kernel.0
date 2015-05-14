From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 14 May 2015 19:14:44 +0900
Subject: [PATCH v7 0/4] ARM: SoC: add a new platform,
 UniPhier (arch/arm/mach-uniphier)
In-Reply-To: <2230140.n6kW8LSSaP@wuerfel>
References: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
 <2101307.fSn8Z2ZyBq@wuerfel>
 <CAK7LNASyJmyUcKNecdhWjXbd615=9XcMxeLxC7y_z+psO03BbQ@mail.gmail.com>
 <2230140.n6kW8LSSaP@wuerfel>
Message-ID: <CAK7LNATvs3y8gt5YrZBcxe-mpbMuFWbXCJRAZoYBOQanvvpeWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-05-13 16:48 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 13 May 2015 16:00:21 Masahiro Yamada wrote:
>> 2015-05-13 0:00 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Friday 08 May 2015 13:07:10 Masahiro Yamada wrote:
>> > Welcome as our latest new maintainer. In the future, please send
>> > any follow-up patches for the architecture specific code to
>> > arm at kernel.org in addition to the normal recipients, once you
>> > consider them ready to be applied.
>>
>>
>> Please teach me a little more because I am not experienced enough
>> in this community.
>>
>>
>> I checked MAINTAINERS, but I could not find arm at kernel.org.
>> Is it documented somewhere?
>>
>> I found ARM SUB-ARCHITECTURES entry in that file, but it does not mention
>> the responsible individuals.
>> (I assume, you and Olof are the ones.)
>>
>
> We normally only take patches from subarch maintainers that know who
> we are and how it works, but we don't want to be Cc'd on every single
> patch, so we don't have an entry in MAINTAINERS directly.

I see.



>> I have one more question.
>>
>> Are you receiving pull requests from each sub-arch maintainer?
>> Or should every patch be submitted to arm at kernel.org and
>> applied by you (or other ARM-SoC maintainers)?
>>
>> I have not earned enough reputations in this ML, so I know
>> it is too early for me to handle pull-reqs.
>>
>> I understand the general development process of Linux, but
>> the maintainership of the ARM-SoC subsystem looks more hierarchized, so
>> I just want to know its development process correctly.
>
> No worries, if you are unsure you can always ask us on the mailing
> list or on the #armlinux channel on irc.freenode.net.
>
> If you have more than a few patches at once, we'd always appreciate
> a pull request, for a couple of patches, emails to arm at kernel.org plus
> linux-arm-kernel are fine as well.
>
> When you do pull requests, please split them up according to larger
> topics, e.g. send dts changes separately from code changes, and
> separate bug fixes, cleanups and new feature support.
>
> Often when you add a new driver, that will require sending the driver
> code to a subsystem maintainer, and the dts changes to us. If everything
> goes well, your DT bindings are both forward and backward compatible,
> so they can get merged independently. If you ever have interdependencies
> between them, talk to us first so we can find a solution.
>
> For sending pull requests, it would be good to have a gpg key that
> is signed by other well-known kernel developers. If you have such
> a key, you can also request a kernel.org account to host a git tree
> there, or you can host a git tree somewhere on your company's domain.
> A public hosting service like github is not as good for us, but we
> can deal with it when you are still ramping up your infrastructure.
> Let me know if you need help finding kernel developers to sign your key.

For now, I am not handling many patches, so I will send them to the ML.

If I need to send pull-reqs someday, I will ask for help.

Many thanks!!

-- 
Best Regards
Masahiro Yamada
