From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 11:00:16 +0200
Subject: [GIT PULL] Xilinx ZynqMP DT changes for v4.3
In-Reply-To: <55BB369F.4080100@monstr.eu>
References: <55BB369F.4080100@monstr.eu>
Message-ID: <20150805090016.GI6390@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:49:35AM +0200, Michal Simek wrote:
> Hi,
> 
> please pull these ARM64 DT patches to your tree.
> 
> Thanks,
> Michal
> 
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.3
> 
> for you to fetch changes up to f49310dc62f68ae9f905f9a1e42224fa23867f47:
> 
>   ARM64: zynqmp: Move SPI nodes to the right location (2015-07-31
> 10:46:34 +0200)
> 
> ----------------------------------------------------------------
> arm: Xilinx ZynqMP dt patches for v4.3
> 
> - Add SATA, GPIO, CAN, SMMU, USB, SPI, I2C, watchdog and sdhci for zynqmp
> - Sort nodes in dtsi

You seem to sort these alphabetically. We normally encourage sorting by unit
address instead. Was there some reason you chose alphabetical?


-Olof
