From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 17:41:08 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.14 (#2)
In-Reply-To: <87r2u783qo.fsf@free-electrons.com>
References: <87r2u783qo.fsf@free-electrons.com>
Message-ID: <CAK8P3a3S39KVTpdGgun6YhLCeyGXJbBMFxPufEwz24iftKQ52g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 5:30 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> mvebu fixes for 4.14 (part 2)
>
> Two device tree related fixes:
>
> - One on Armada 38x using a other compatible string for I2C in order
>   to cover an errata.
>
> - One for Armada 7K/8K fixing a typo on interrupt-map property for
>   PCIe leading to fail PME and AER root port service initialization
>
> And the last one for the mbus fixing the window size calculation when
> it exceed 32bits

Pulled into fixes, thanks!

       Arnd
