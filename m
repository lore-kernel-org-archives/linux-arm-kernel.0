From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 11:57:17 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.15
In-Reply-To: <20171020080021.bsumte7ppspgrtln@flea>
References: <20171020080021.bsumte7ppspgrtln@flea>
Message-ID: <CAK8P3a2n-uHLniHG11uuAM+GCRenB-OkUO3BU5Z8Jc3zjeE64w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 10:00 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> Here are the arm32 DT changes for the next merge window. Due to
> conflicts, it is based on the fixes tag I sent previously.

> ----------------------------------------------------------------
> Allwinner DT changes for 4.15
>
> The most notable changes are:
>   - Conversion to the last SoC (A10, A20) to the new clock framework
>   - HDMI and dual pipeline support for the A10, A20 and A31 DRM driver
>   - Support for the various power supplies on a number of boards
>   - Fix of DTC warnings on a number of SoCs, but most of them still need
>     some work
>   - New boards: A20-OLinuXino-MICRO-eMMC, TBS A711, Banana Pi M2 Berry,
>     Banana Pi M2 Ultra

I added the line 'New R40 SoC support' here so I remember. Hope that's ok.

I had a number of conflicts against Rob's "remove leading zeroes" patch. The
merges were all easy enough, but please check the next/dt branch and confirm
that I got it right.

Thanks,

       Arnd
