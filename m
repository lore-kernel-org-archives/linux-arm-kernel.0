From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 17:28:47 -0800
Subject: [GIT PULL] ARM64: Xilinx ZynqMP SoC patches for v4.16
In-Reply-To: <84cfd3d5-f0e7-23dc-0e33-430a1f2dbdb0@monstr.eu>
References: <84cfd3d5-f0e7-23dc-0e33-430a1f2dbdb0@monstr.eu>
Message-ID: <20180112012847.iqol2xb2iro6wauk@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 02:02:18PM +0100, Michal Simek wrote:
> Hi guys,
> 
> please consider to pull these 3 patches to your tree. I have discussed
> it with Arnd that this could be probably fine even it is a little bit late.
> 
> Thanks,
> Michal
> 
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-4.16
> 
> for you to fetch changes up to cee8113a295acfc4cd25728d7c3d44e6bc3bbff9:
> 
>   soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
> (2018-01-08 13:42:47 +0100)
> 
> ----------------------------------------------------------------
> arm: Xilinx ZynqMP SoC patches for v4.16
> 
> - Create drivers/soc/xilinx folder structure
> - Add ZynqMP vcu init driver
> 
> ----------------------------------------------------------------
> Dhaval Shah (2):
>       dt-bindings: soc: xilinx: Add DT bindings to xlnx_vcu driver
>       soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
> 
> Michal Simek (1):
>       soc: xilinx: Create folder structure for soc specific drivers
> 

Merged, but you should probably add a platform config option for Xilinx
and use that instead of obj-y to descend into the directory?


-Olof
