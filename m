From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Sep 2013 15:01:30 -0700
Subject: Tegra baseline test results for v3.12-rc1
In-Reply-To: <A4DCC42E2B5835498682FCB0A8F9F873378C267FFD@HQMAIL04.nvidia.com>
References: <A4DCC42E2B5835498682FCB0A8F9F873378C267FFD@HQMAIL04.nvidia.com>
Message-ID: <CAOesGMjAQZMUdC9ZoGhX=zEA3HCky1zwE0-B6fNAJubqO9bVzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 18, 2013 at 9:23 AM, Paul Walmsley <pwalmsley@nvidia.com> wrote:

> vmlinux object size
> (delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267)):
>    text     data      bss    total  kernel
>  -89208   +10000     -416   -79624  multi_v7_defconfig
> +299303    +7244    +1484  +308031  tegra_defconfig
>
>
> Boot-time memory difference
> (delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267))
>     avail    rsrvd     high    freed                board              kconfig                  dtb
>         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
>     -324k     324k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
>     -324k     324k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
>     -592k     592k        .       8k       tegra30-beaver      tegra_defconfig       tegra30-beaver

Hm. These deltas are huge. :(  It would be interesting to know where
they come from.


-Olof
