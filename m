From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 07:02:35 -0700
Subject: [GIT PULL 2/5] i.MX SoC changes for 4.12
In-Reply-To: <1491835076-1995-2-git-send-email-shawnguo@kernel.org>
References: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
 <1491835076-1995-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170419140235.GK29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 10:37:53PM +0800, Shawn Guo wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.12
> 
> for you to fetch changes up to ff8abc2839bfab9185978f3c27b5e3b744262efd:
> 
>   ARM: mxs: add support for I2SE Duckbill 2 boards (2017-04-10 21:25:50 +0800)
> 
> ----------------------------------------------------------------
> i.MX SoC changes for 4.12:
>  - A correction on mmdc_pmu_write_accesses event definition.
>  - Add new axi_id perf command to support MMDC filter memory usage
>    profiling.
>  - Set correct SPI chip_select in platform device registration, so that
>    spi-imx driver code can be improved to use chip_select directly for
>    harwdare setup instead of indirectly via the cs_gpio mapping array.

The patch subject on this one was a bit on the vague side, it's hard to tell
when just looking at the git long --oneline what it's about.  Something to
think about for future stuff, no need to respin to fix.

>  - Disable APIS bus supervisor protect for i.MX25, since the default
>    configuration doesn't work for a few peripherals accessed through
>    SDMA.
>  - Add compatible check for the secondary generation of I2SE i.MX28
>    Duckbill board support.

Merged, thanks!


-Olof
