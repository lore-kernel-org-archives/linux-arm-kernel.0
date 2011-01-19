From: stanley.miao@windriver.com (Stanley.Miao)
Date: Wed, 19 Jan 2011 14:44:44 +0800
Subject: [PATCH V2 0/3] Support BE8 kernel modules relocation
Message-ID: <1295419487-31185-1-git-send-email-stanley.miao@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from V1:
1, move the defintion of read_instr32/write_instr32 from arm/include/asm/io.h to arm/kernel/module.c


The first patch is to solve the BE8 kernel modules relocation problems.

The second patch is to support BE8 kernel on a little-endian machine.

The third patch is to add some debug macros to help the developer to location the boot problems.

In order to test the first patch, I am sure some people will need the other two patches, so I send them together.

Stanley.
