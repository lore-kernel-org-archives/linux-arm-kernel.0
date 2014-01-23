From: monstr@monstr.eu (Michal Simek)
Date: Thu, 23 Jan 2014 15:49:53 +0100
Subject: [PATCH] tty: uartps: Initialize ports according to aliases
In-Reply-To: <c1882ea5f2e45b19cc1930b624254cb1b59b2fe0.1390488303.git.michal.simek@xilinx.com>
References: <c1882ea5f2e45b19cc1930b624254cb1b59b2fe0.1390488303.git.michal.simek@xilinx.com>
Message-ID: <52E12C11.4090008@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2014 03:45 PM, Michal Simek wrote:
> Register port numbers according to order in DT aliases.
> If aliases are not defined, order in DT is used.
> If aliases are defined, register port id based
> on that.
> This patch ensures proper ttyPS0/1 assignment.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---

oou - Ignore this version - will send v2.

Sorry,
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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140123/6108878a/attachment-0001.sig>
