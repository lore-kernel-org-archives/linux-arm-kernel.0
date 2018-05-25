From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 05:22:15 -0700
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v4.18
In-Reply-To: <CAK7LNASUq_9osPdzbiMCbYzeqc=W3Yv7tB63V+5gXqcZ9QBtYA@mail.gmail.com>
References: <CAK7LNASUq_9osPdzbiMCbYzeqc=W3Yv7tB63V+5gXqcZ9QBtYA@mail.gmail.com>
Message-ID: <20180525122215.ylx35lkdcbr5qmkw@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 11:38:39AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are UniPhier DT (64bit) updates for the v4.18 merge window.
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
> tags/uniphier-dt64-v4.18
> 
> for you to fetch changes up to b076ff8bddfba793d49bca14feb49a0e84f41843:
> 
>   arm64: dts: uniphier: add syscon-phy-mode property to each ethernet
> node (2018-04-25 00:21:14 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v4.18
> 
> - add more properties to ethernet nodes
> 
> ----------------------------------------------------------------
> Kunihiko Hayashi (2):
>       arm64: dts: uniphier: add clock-names and reset-names to ethernet node
>       arm64: dts: uniphier: add syscon-phy-mode property to each ethernet node

Merged, same comment as for the 32-bit pull request. Thanks!


-Olof
