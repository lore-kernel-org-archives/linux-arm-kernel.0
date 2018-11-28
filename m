From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 28 Nov 2018 18:53:04 +0100
Subject: [PATCH v4 0/20] MMP platform fixes
Message-ID: <20181128175324.163202-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series contains contains a bunch of MMP2 platform fixes.

Previous spins of the patch set were sent out over the course of last
three months to the MMP platform maintainers, with Arnd and
linux-arm-kernel at lists.infradead.org on copy.

Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
seem to respond anymore. That's a shame, because the MMP2 support seems to
in need for some love. The DT/multiplatform kernels can't even boot without
14/20, 15/20 and perhaps more.

I'm wondering if this cat gen in via the arm-soc tree? Would it be
appropriate if I followed up with a MAINTAINERS update in that case?

The patch set has been tested on an OLPC XO-1.75 laptop.

Thanks
Lubo
