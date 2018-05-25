From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 05:21:34 -0700
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.18
In-Reply-To: <CAK7LNATphrRyYvMXMMJz--UtfNk2BZLWHAp3XXpQLob5=5w2Qg@mail.gmail.com>
References: <CAK7LNATphrRyYvMXMMJz--UtfNk2BZLWHAp3XXpQLob5=5w2Qg@mail.gmail.com>
Message-ID: <20180525122134.zigckjuxovguyc7a@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 11:34:08AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are UniPhier DT (32bit) updates for the v4.18 merge window.
> Please pull!
> 
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.18
> 
> for you to fetch changes up to 526f872b8492fbfb1a0f342e601bdc5ba322f16b:
> 
>   ARM: dts: uniphier: add syscon-phy-mode property to each ethernet
> node (2018-04-25 00:21:51 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.18
> 
> - add more properties to ethernet nodes
> 
> ----------------------------------------------------------------
> Kunihiko Hayashi (2):
>       ARM: dts: uniphier: add required clocks and resets to Pro4 ethernet node
>       ARM: dts: uniphier: add syscon-phy-mode property to each ethernet node

Hi,

Merged, but please spend a little more effort on the tag description (what are
these new properties giving you in functionality?)


-Olof
