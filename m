From: monstr@monstr.eu (Michal Simek)
Date: Thu, 25 Feb 2016 14:04:23 +0100
Subject: [PATCH v2] serial: xuartps: Enable OF earlycon support
In-Reply-To: <56C5F670.50005@hurleysoftware.com>
References: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
 <56C5F670.50005@hurleysoftware.com>
Message-ID: <56CEFBD7.40008@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 18.2.2016 17:50, Peter Hurley wrote:
> On 02/17/2016 11:57 PM, Michal Simek wrote:
>> Support early console setup via DT for all listed compatible strings.
>> Remove EARLYCON_DECLARE which was done by:
>> "Use common framework for earlycon declarations"
>> (sha1: 2eaa790989e03900298ad24f77f1086dbbc1aebd)
>> when OF_EARLYCON_DECLARE is defined.
> 
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Can you please add it your queue for 4.6?
Or can we merge it via arm-soc tree as was suggested by Arnd here?
https://lkml.org/lkml/2016/2/16/315

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/a8164c32/attachment.sig>
