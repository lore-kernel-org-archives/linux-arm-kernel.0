From: olof@lixom.net (Olof Johansson)
Date: Fri, 20 Dec 2013 08:50:26 -0800
Subject: [PATCH 1/3] ARM: hisi: rename hi3xxx to hisi
In-Reply-To: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
References: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAOesGMjaJVWoMWgywkHfeD+0TMw3pze40CAvTcuC7+NavMq22w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 6:52 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> Since some new Hisilicon SoCs are not named as hi3xxx, rename mach-hi3xxx
> to mach-hisi instead. And the pronounciation of "hisi" is similar to the
> chinese pronounciation of Hisilicon. So Hisilicon guys like this name.
>
> ARCH_HI3xxx will be renamed later since other drivers are using it and
> they are still in linux-next git tree. So rename ARCH_HI3xxx later.
>

Are you kidding me? We JUST merge your platform after a very painful
review with many fumbly cycles, and the very first thing you do is
rename it?

I even complained about the crazy numbering and naming, and you didn't
fix it while we were in review, and now just days after we merge the
patches this one comes out?

For now, we'll drop your original branch and fold in these patches
with the original ones. There's no point in checking in a platform
just to rename it, so we'll do the fixups.

No further action is required on your behalf right now but it will be
a while until we sort this out. It's at the back of the queue of
things to deal with right now.


-Olof
