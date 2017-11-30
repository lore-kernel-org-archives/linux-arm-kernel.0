From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Nov 2017 10:02:26 +0100
Subject: [PATCH v3 0/6] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171130004510.23887-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130004510.23887-1-lukma@denx.de>
Message-ID: <CAK8P3a3uWpe6HBtt-XPW0H_VTjes-GpSouvs4JHXmQ2ZcvhsEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 1:45 AM, Lukasz Majewski <lukma@denx.de> wrote:
> This patch series adds support for Liebherr's BK3 board, being
> a derivative of TS72XX design.
>
> This patchset consists of following patches:
>
> - ts72xx.[c|h] cosmetic cleanup/improvement
> - Rewrite ts72xx.c to be reusable by bk3
> - The Liebherr's BK3 board has been added with re-using code of
>   ts72xx.c (detalied list of changes can be found in patch 6/6)
>
> This series applies on top of v4.14

Can we clarify who is picking up ep93xx patches these days? The
last time I think Linus Walleij offered to do it for the 4.14 merge window,
as neither Hartley nor Alexander had a git tree.

I don't care too much who does it in the end, between Hartley, Alexander,
Linus and even Lukasz directly, but I'd like whoever feels responsible
for the platform to be listed in the MAINTAINERS file and pick up
the patches from everyone else to forward them to me as either
pull requests or separate patches to arm at kernel.org when the
patches are ready, so I don't have to make a decision about when to
pick them up from the list.

        Arnd
