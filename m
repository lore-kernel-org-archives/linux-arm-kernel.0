From: olof@lixom.net (Olof Johansson)
Date: Wed, 23 Jan 2013 20:33:34 -0800
Subject: [GIT PULL][for 3.8] request from armsoc/fix branch in pxa git tree
In-Reply-To: <CAN1soZzTnVhMwQfOz7=MyHm7b6n=OmNL=wEENJz-SFOPU6Wsjw@mail.gmail.com>
References: <CAN1soZzTnVhMwQfOz7=MyHm7b6n=OmNL=wEENJz-SFOPU6Wsjw@mail.gmail.com>
Message-ID: <CAOesGMjfJ6A37Ncek8221dsYNzf6pZNYYD-XOt4hoa9TD_VYAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 23, 2013 at 1:15 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Hi Arnd & Olof,
>
> Please help to pull armsoc/fix branch in pxa git tree.
>
> Regards
> Haojian
>
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
>
>   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
>
> are available in the git repository at:
>
>   git://github.com/hzhuang1/linux.git armsoc/fix
>
> for you to fetch changes up to eea6e39b916dd282c7fa4629be8934b5ad60e62b:
>
>   ARM: pxa: Minor naming fixes in spitz.c (2013-01-23 17:13:07 +0800)
>
> ----------------------------------------------------------------
> Igor Grinberg (1):
>       ARM: PXA3xx: program the CSMSADRCFG register
>
> Marko Katic (1):
>       ARM: pxa: Minor naming fixes in spitz.c
>
> Mike Dunn (2):
>       ARM: palmtreo: fix lcd initilialization on treo680
>       ARM: palmtreo: fix #ifdefs for leds-gpio device

I don't think some of those really are regressions, are they? I.e. the
palmtreo fixes are for code that never in recent times worked I think?

If so, I'd prefer to queue this for 3.9 as a fixes-non-critical
instead, please let me know if that's ok.

Thanks,

-Olof
