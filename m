From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 22:44:56 +0200
Subject: [GIT PULL 2/4] defconfig changes for omaps for v4.14
In-Reply-To: <-2831898822533480273@unknownmsgid>
References: <-2831898822533480273@unknownmsgid>
Message-ID: <CAK8P3a2CaT4KxGHJRkyuu+0i_NGN876E7X8YZ+dm8-27PG5ffQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 9b51f04424e17051a89ab32d892ca66b2a104825:
>
>   Merge branch 'parisc-4.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2017-07-05 17:41:31 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/defconfig-signed
>
> for you to fetch changes up to 6a60a2aca111fd71c5229dbcb3de8ecf0e0e9a12:
>
>   ARM: omap2plus_defconfig: Enable LP87565 (2017-08-14 10:33:49 -0700)
>
> ----------------------------------------------------------------
> Defconfig updates for omaps for v4.14 to enable DP83867
> phy driver on dra72x and dra71x evm, and LP87565 that is
> on dra76-evm.

Pulled into next/defconfig, thanks!

Should we enable those drivers on multi_v7_defconfig as well?

       Arnd
