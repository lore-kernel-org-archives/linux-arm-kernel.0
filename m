From: monstr@monstr.eu (Michal Simek)
Date: Tue, 10 Nov 2015 09:19:33 +0100
Subject: [PATCH] ARM: dt: zynq: Add labels to cpu nodes to allow
 overriding OPPs.
In-Reply-To: <20151109185555.GN6436@xsjsorenbubuntu>
References: <1447095111-22969-1-git-send-email-moritz.fischer@ettus.com>
 <20151109185555.GN6436@xsjsorenbubuntu>
Message-ID: <5641A895.6040200@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2015 07:55 PM, S?ren Brinkmann wrote:
> On Mon, 2015-11-09 at 10:51AM -0800, Moritz Fischer wrote:
>> By adding labels to the cpu nodes in the dtsi, a dts that
>> includes it can change the OPPs by referencing the cpu0
>> through the label.
>>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

Applied to zynq/dt.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151110/13189a22/attachment.sig>
