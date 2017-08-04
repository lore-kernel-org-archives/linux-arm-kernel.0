From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 12:54:15 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.13 (#2)
In-Reply-To: <87fuda9icy.fsf@free-electrons.com>
References: <87fuda9icy.fsf@free-electrons.com>
Message-ID: <CAK8P3a1C7D8ZeqSBzPk1-P6vZJYTELHCHeSbPF6n9JjhCP=_HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 4:03 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> ----------------------------------------------------------------
> mvebu fixes for 4.13 (part 2)
>
> All the fixes are for ARM64 mvebu:
>
>  - Fix the RTC interrupt on A7K/A8K which was missed when switching
>    from GIC to ICU
>  - Mark the A7K/A8K crypto engine as dma coherent
>  - Fix the number of GPIO on south bridge on Armada 3700
>

Pulled into fixes, thanks!

       Arnd
