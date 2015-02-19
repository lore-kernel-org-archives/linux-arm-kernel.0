From: sanjeevsharmaengg@gmail.com (sanjeev sharma)
Date: Thu, 19 Feb 2015 13:14:27 +0530
Subject: GIC set affinity confusion on ARM
Message-ID: <CAGUYZuQiKKxbysuseW8cntLrx_1=iYRpSOj45+XLT7x7LEYdjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,

Current code of gic_set_affinity() on mainline Tree send interrupt to
one CPU only. Is this intentionally left feature to not wake up all
other CPU in SMP Environment ?

Regards
Sanjeev Sharma
