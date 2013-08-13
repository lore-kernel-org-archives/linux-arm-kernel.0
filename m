From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 13 Aug 2013 15:46:27 -0700
Subject: arm-soc: Xilinx Zynq DT changes for v3.12
In-Reply-To: <520A47C3.5000106@monstr.eu> (Michal Simek's message of "Tue, 13
 Aug 2013 16:50:43 +0200")
References: <520A47C3.5000106@monstr.eu>
Message-ID: <87r4dxfbuk.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Michal Simek <monstr@monstr.eu> writes:

> Hi Arnd and Olof,

I'm now helping out with arm-soc maintenance as well, and am on the
arm at kernel.org alias, so thanks for Cc'ing it.

> please pull this simple DT change to your tree.

Pulled into next/dt.

In the future, it makes things simpler for us if you base on older -rc
releases where possible (c.f. similar request by Olof[1].)  In this
case, it was trivial for me to rebase it onto -rc1 so I've done that
before applying.

Thanks,

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/189115.html
