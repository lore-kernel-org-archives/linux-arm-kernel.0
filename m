From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 15:05:25 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.17 (#1)
In-Reply-To: <87lgf12mro.fsf@bootlin.com>
References: <87lgf12mro.fsf@bootlin.com>
Message-ID: <CAK8P3a3fJupbVAXVu6rjXA4+U6X4pO+WADiUWKp_m0jU65is5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 6:15 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> ----------------------------------------------------------------
> mvebu dt64 for 4.17 (part 1)
>
> - convert to the SPDX-License-Identifier
> - add missing clocks (for the registers) on some of the peripherals
> - use the new nand driver
> - add more uart for Armada 7K/8K SoCs

Pulled into next/dt. I had to double-check the way that the nand binding
changes are staged out, and found that it is intentionally done in a way
that is bisectable and that still allows the use of old DTB files with new
kernels, but that breaks new DTBs on old kernels. This is all fine, but
it also helps to put that kind of information into the changelog.

Thanks,

       Arnd
