From: monstr@monstr.eu (Michal Simek)
Date: Fri, 2 Mar 2018 19:34:55 +0100
Subject: [PATCH v2 2/8] arm64: zynqmp: Add support for Xilinx zcu100-revC
In-Reply-To: <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <26229dbbeb0ced5db870a8cf636f6d3d5855199e.1519396753.git.michal.simek@xilinx.com>
 <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>
Message-ID: <c9d4bc3a-888e-3faf-4b1d-6ad309048078@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2.3.2018 17:40, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 03:40:24PM +0100, Michal Simek wrote:
>> This board has 2GB of memory, i2c, sd, wifi sdio, spis, uarts, display
>> port and usbs.
>> Board is using fixed clocks because clock driver hasn't been merged yet.
> 
> Please get rid of the separate clocks dts file when it is merged.

Will do.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/d3f5d9c1/attachment.sig>
