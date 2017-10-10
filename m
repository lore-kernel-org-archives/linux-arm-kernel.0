From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Oct 2017 08:19:24 +0100
Subject: linux-next: build failure after merge of the keystone tree
Message-ID: <20171010071924.ddxkylkwq44qh47q@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

After merging the keystone tree, today's linux-next build
(multi_v7_defconfig) failed like this:

  DTC     arch/arm/boot/dts/keystone-k2g-evm.dtb
Error: /home/broonie/tmpfs/next/arch/arm/boot/dts/keystone-k2g-evm.dts:150.1-15 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:316: recipe for target 'arch/arm/boot/dts/keystone-k2g-evm.dtb' failed
make[2]: *** [arch/arm/boot/dts/keystone-k2g-evm.dtb] Error 1

Caused by commit

   a6f244505915f ("ARM: dts: keystone-k2g-evm: Add I2C EEPROM DT entry")

I've used the keystone tree from yesterday.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171010/d72928b9/attachment.sig>
