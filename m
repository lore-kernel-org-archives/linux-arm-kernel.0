From: xuwei5@hisilicon.com (xuwei (O))
Date: Mon, 23 Dec 2013 01:09:48 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvM10gQVJNOiBoaXNpOiByZW5hbWUgaGkzeHh4IHRv?=
 =?gb2312?Q?_hisi?=
In-Reply-To: <87sitnh1bz.fsf@linaro.org>
References: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
 <CAOesGMjaJVWoMWgywkHfeD+0TMw3pze40CAvTcuC7+NavMq22w@mail.gmail.com>
 <87sitnh1bz.fsf@linaro.org>
Message-ID: <8B36690B4C1B584EAD95DD4902A4FF37095E90C3@SZXEMA511-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Kevin,

Please calm down.
Both of us have a hard time to enable hi3xxx in kernel v3.14.
Let me explain it.

We have a new serial of SoCs for server market and they will named with hipxx.
And hi3xxx SoCs are for the mobile and STB market.
Now we hope to enable the hipxx SoCs in the kernel.
To make the "mach" directory simple, we hope hipxx SoCs could share the same directory with hi3xxx.
But according current situation, maybe we should add a new "mach" for the hipxx firstly.
Do you think is it OK?
 
And for hi3xxx SoCs, could you please keep it in the next?

Best Regards,
Wei Xu


> -----????-----
> ???: Kevin Hilman [mailto:khilman at linaro.org]
> ????: 2013?12?21? 1:36
> ???: Olof Johansson
> ??: Haojian Zhuang; xuwei (O); Arnd Bergmann;
> linux-arm-kernel at lists.infradead.org; Haojian Zhuang
> ??: Re: [PATCH 1/3] ARM: hisi: rename hi3xxx to hisi
> 
> Olof Johansson <olof@lixom.net> writes:
> 
> > On Thu, Dec 19, 2013 at 6:52 PM, Haojian Zhuang
> > <haojian.zhuang@linaro.org> wrote:
> >> Since some new Hisilicon SoCs are not named as hi3xxx, rename
> >> mach-hi3xxx to mach-hisi instead. And the pronounciation of "hisi" is
> >> similar to the chinese pronounciation of Hisilicon. So Hisilicon guys like this
> name.
> >>
> >> ARCH_HI3xxx will be renamed later since other drivers are using it
> >> and they are still in linux-next git tree. So rename ARCH_HI3xxx later.
> >>
> >
> > Are you kidding me? We JUST merge your platform after a very painful
> > review with many fumbly cycles, and the very first thing you do is
> > rename it?
> >
> > I even complained about the crazy numbering and naming, and you didn't
> > fix it while we were in review, and now just days after we merge the
> > patches this one comes out?
> >
> > For now, we'll drop your original branch and fold in these patches
> > with the original ones. There's no point in checking in a platform
> > just to rename it, so we'll do the fixups.
> 
> Agreed. I've dropped the hi3xxx/soc branch from next/soc and rebuild for-next
> without it.
> 
> Kevin
> 
