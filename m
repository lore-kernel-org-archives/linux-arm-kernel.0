From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Sep 2013 10:05:11 -0700
Subject: [GIT PULL] Removeal of 0x's from DT address spaces
In-Reply-To: <20130919104639.GD22389@lee--X1>
References: <20130919104639.GD22389@lee--X1>
Message-ID: <CAOesGMib-qWkADsUAdDUg106gnVpM+5M+2vUMnJ=U4M4AyE8kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 3:46 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Hi ARM-SoC,
>
> This is the remainder of a patchset that's been on the MLs for quite a
> while now. It's a simple set which removes the unecessary '0x's from
> device node headers i.e. s/dev at 0xaaaaaaaa/dev at aaaaaaaa/. Most of the
> patches have been taken in by individual maintainers and this is
> what's left.
>
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git tb-0x-removeal
>
> for you to fetch changes up to 5621ed85635680def9bbf75c107b20bb913f14bb:
>
>   ARM: SPEAr3xx: DT: Remove '0x's from Spear 320 DTS file (2013-09-19 11:36:20 +0100)
>
> ----------------------------------------------------------------
> Lee Jones (5):
>       ARM: ux500: Remove '0x's from HREF v60+ DTS file
>       ARM: at91: dt: Remove '0x's from Animeo IP DTS file
>       ARM: SPEAr3xx: DT: Remove '0x's from Spear 300 DTS file
>       ARM: SPEAr3xx: DT: Remove '0x's from Spear 310 DTS file
>       ARM: SPEAr3xx: DT: Remove '0x's from Spear 320 DTS file

There's really no need to post one patch per file. Please fold the
spear ones together at least, and repost. If you cc us on the patches
we'll apply them.



-Olof
