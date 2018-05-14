From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 13:29:57 -0700
Subject: [GIT PULL 5/5] Broadcom soc changes for 4.18
In-Reply-To: <20180511214339.24139-5-f.fainelli@gmail.com>
References: <20180511214339.24139-1-f.fainelli@gmail.com>
 <20180511214339.24139-5-f.fainelli@gmail.com>
Message-ID: <20180514202957.jrh2xvy3rfvud7bl@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 02:43:38PM -0700, Florian Fainelli wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/soc
> 
> for you to fetch changes up to 56e4446df9c1214e886fdc7603a5c1cb99cb1843:
> 
>   ARM: brcmstb: Add support for the V7 memory map (2018-05-09 12:14:42 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based machine/platform files
> changes for 4.18, please pull the following:
> 
> - Doug updates arch/arm/include/asm/cpuinfo.h such that this header file
> can be used by both C and assembly code. This particular change will
> also be included in a Sunxi pull request to support A83T SMP support.
> 
> - Doug also updates our DEBUG_LL routine to support newer chips such as
> 7278 which have a version 7 memory map which moves the registers from
> physical address 0xf000_0000 down to 0x0800_0000. This requires us to
> look up the processor MIDR and determine the base address from the
> PERIPHBASE register.
> 
> - Florian updates the Brahma-B15 read-ahead cache implementation such
> that it works on the Brahma-B53 CPUs, which also have an identical
> read-ahead cache implementation, with a different set of offsets. He
> also provides the Brahma-B15 MIDR definition such that it can be used by
> other pieces of code in the future.

Merged, thanks.


-Olof
