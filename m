From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:30:50 -0800
Subject: [GIT PULL 2/2] SoCFPGA defconfig updates for v4.10
In-Reply-To: <20161111205915.22173-2-dinguyen@kernel.org>
References: <20161111205915.22173-1-dinguyen@kernel.org>
 <20161111205915.22173-2-dinguyen@kernel.org>
Message-ID: <20161118073050.GH1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 02:59:15PM -0600, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull these defconfig updates for v4.10.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_defconfig_updates_for_v4.10
> 
> for you to fetch changes up to cab004fa972f06b236ba6b592bbb0512d5c6c158:
> 
>   ARM: socfpga_defconfig: enable FS configs to support Angstrom filesystem (2016-11-09 08:11:31 -0600)
> 
> ----------------------------------------------------------------
> SoCFPGA defconfig updates for v4.10
> - enable QSPI, HIGHMEM, FPGA bridge and device-tree overlays
> - enable AUTOFS4 and NFS file system support
> 
> ----------------------------------------------------------------
> Alan Tull (1):
>       ARM: socfpga: updates for socfpga_defconfig
> 
> Dinh Nguyen (2):
>       ARM: socfpga_defconfig: Enable HIGHMEM
>       ARM: socfpga_defconfig: enable FS configs to support Angstrom filesystem
> 
> Steffen Trumtrar (1):
>       ARM: socfpga: defconfig: enable qspi

Merged, thanks.


-Olof
