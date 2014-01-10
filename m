From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 10 Jan 2014 16:56:46 +0800
Subject: [GIT PULL] ARM: SoC fixes for 3.13
In-Reply-To: <20140109085251.GA30534@quad.lixom.net>
References: <20140109085251.GA30534@quad.lixom.net>
Message-ID: <CA+55aFx-+qP=8cz4xrwjde1sknObwjan3CUvg-n1StNMpr0Fcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 9, 2014 at 4:52 PM, Olof Johansson <olof@lixom.net> wrote:
>
> ARM: SoC fixes for 3.13-rc
>
> Hopefully the last set of arm-soc fixes for 3.13, or at least only a
> few stray patches after this.
>
> There are a few fixes for Renesas platforms to fixup DMA masks (this
> started causing errors once the DMA API added checks for valid masks in
> 3.13). Two more dealing with resources for MMC and PWM setup.
>
> There's also a few TI/OMAP/DRA fixes for smaller stuff and a fix for
> compilation failures on a PXA platform.

Hmm. Most of that was all in your _previous_ pull request. When I pull
this time, I just get the few fixes for  Renesas DMA masks.

I pulled that and edited up the resulting merge message, but you
should double-check that I now have what you expected. Because your
pull request seems a bit confused about what's been going on..

           Linus
