From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jul 2017 12:55:22 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.13 (#1)
In-Reply-To: <87shhu84iq.fsf@free-electrons.com>
References: <87shhu84iq.fsf@free-electrons.com>
Message-ID: <CAK8P3a1DZFb2xdp3CKT1XhjQVJC3SNCYz_b-jV3djGtWS-Z9vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 11:42 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> ----------------------------------------------------------------
> mvebu fixes for 4.13 (part 1)
>
> - Fix wrong irq type for gpio expeander on Armada 388 GP
> - Use __pa_symbol instead of virt_to_phys in the mv98dx3236 platform
>   SMP code

Pulled into fixes, thanks!

       Arnd
