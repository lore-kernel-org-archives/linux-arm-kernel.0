From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 18:04:22 +0100
Subject: [GIT PULL v2 2/5] soc/tegra: Changes for v4.16-rc1
In-Reply-To: <20171221161252.12920-1-thierry.reding@gmail.com>
References: <20171220191900.757-2-thierry.reding@gmail.com>
 <20171221161252.12920-1-thierry.reding@gmail.com>
Message-ID: <CAK8P3a1Z6vD982A9y2zaa+x+2qTdtjbFYw_TcnvwvFD1t5CZjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 5:12 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

>
>   soc/tegra: fuse: Explicitly request DMA channel from APB DMA driver (2017-12-21 17:04:12 +0100)
>
> This includes two additional patches that have been sitting in patchwork
> for a long time and that I had forgotten to include. Please ignore the
> first pull request and pull this instead.
>
> Thanks,
> Thierry
>
> ----------------------------------------------------------------
> soc/tegra: Changes for v4.16-rc1
>
> Fuse and chip ID support for Tegra186 is added in this set of changes,
> followed by some unification work for the PMC driver in order to avoid
> code duplication between Tegra186 and prior chips.
>
> This also contains a couple of fixes for reading fuses on Tegra20.

Pulled into next/soc, thanks!

       Arnd
