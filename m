From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 22:24:33 +0200
Subject: [GIT PULL 3/4] non-urgent dts fixes for omaps for v4.14
In-Reply-To: <-6222202649444907883@unknownmsgid>
References: <-6222202649444907883@unknownmsgid>
Message-ID: <CAK8P3a1AwN7Rq3OQJYV=BE9Nr8HdMrncfvmLq3NRT5+KTENasA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:
>
>   ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-not-urgent-dt-signed
>
> for you to fetch changes up to 83f51f06d132c5430b4ac5065ce3594fc4c99aaa:
>
>   ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap (2017-08-10 10:32:17 -0700)
>
> ----------------------------------------------------------------
> Two non-urgent dts fixes for dra7 Ethernet quirk. These are sent
> separately from the rest of the dts changes to avoid merge conflicts
> as these depend on earlier fixes sent during v4.13-rc cycle.

I pulled them into next/cleanup branch (which contains simple fixes as well).
I don't think there was actually a need to keep them separate from the rest
though, you can always base your branches on your own bugfixes that
already got merged, unless I misunderstood the point of having them
separate.

      Arnd
