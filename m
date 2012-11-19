From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Nov 2012 08:52:42 -0800
Subject: [GIT PULL] at91: fixes for 3.7-rc7
In-Reply-To: <50AA5ED5.8090901@atmel.com>
References: <50AA5ED5.8090901@atmel.com>
Message-ID: <CAOesGMjAYtEkmEYnzCQ4G821BWG9D6LHvgt5aOMJgus_hzFkRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Mon, Nov 19, 2012 at 8:31 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof,
>
> Here is another "fixes" pull request for AT91. It enables the sd/mmc driver
> for Device Tree enabled platforms. Those patches where part of a series that
> was split in two for reaching upstream: the MMC part is already in Linus' tree
> and this is the arm-soc part.
> I have placed these patches on top of the fixes that you already have for AT91.

What regressions do these fixes resolve?

It looks more like they are DT-enablement patches to me, and thus 3.8
material, not 3.7. I'll be happy to queue them up in next/dt though.

Thanks,

-Olof
