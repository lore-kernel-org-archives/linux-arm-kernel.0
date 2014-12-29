From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Dec 2014 14:25:24 -0200
Subject: Generic slave capabilities reporting
Message-ID: <CAOMZO5CPcRFJEsnYuATESSArcCbiVCGuAhdq67iR7hF3UPbs6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Since commit ecc19d17868be9c ("dmaengine: Add a warning for drivers
not using the generic slave caps retrieval") I am getting the
following warning on mx6:

[    0.113023] ------------[ cut here ]------------
[    0.113053] WARNING: CPU: 0 PID: 1 at drivers/dma/dmaengine.c:830
dma_async_device_register+0x2a0/0x4c8()
[    0.113063] this driver doesn't support generic slave capabilities reporting
[    0.113073] Modules linked in:
[    0.113094] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.19.0-rc1-next-20141226 #2297
[    0.113104] Hardware name: Freescale i.MX6 SoloX (Device Tree)

What dma driver could I take as an example to implement this generic
slave capabilities reporting?

Thanks,

Fabio Estevam
