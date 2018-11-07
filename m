From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Nov 2018 08:02:17 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.20
In-Reply-To: <cover.1541514075.git.horms+renesas@verge.net.au>
References: <cover.1541514075.git.horms+renesas@verge.net.au>
Message-ID: <CAOesGMjosJGENSm8jjAaZxcr4ehjBB5LF7OQ8PJR-J2kMktfWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 3:25 AM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC fixes for v4.20.
>
>
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
>
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.20
>
> for you to fetch changes up to eab53fdfd60a84b0cc514d4f1f5d79226c76df01:
>
>   arm64: dts: renesas: condor: switch from EtherAVB to GEther (2018-11-05 15:08:44 +0100)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v4.20
>
> * R-Car V3H (r8a77980) based Condor board
>   - Switch from EtherAVB to GEther to match offical boards
>
> * RZ/G2E (ra8774c0) SoC: correct documentation of part number

I have to admit, Renesas part numbers have got to be _really_ hard to
deal with for anyone who has even the slightest hint of dyslexia. :-)

> * R-Car H3 (r8a7795) SoC: reinstate all DMA channels on HSCIF2

Thanks Simon! I've merged this branch now.


-Olof
