From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 16:31:33 +0100
Subject: Generic slave capabilities reporting
In-Reply-To: <CAOMZO5CPcRFJEsnYuATESSArcCbiVCGuAhdq67iR7hF3UPbs6Q@mail.gmail.com>
References: <CAOMZO5CPcRFJEsnYuATESSArcCbiVCGuAhdq67iR7hF3UPbs6Q@mail.gmail.com>
Message-ID: <20150106153133.GN7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Dec 29, 2014 at 02:25:24PM -0200, Fabio Estevam wrote:
> Hi Maxime,
> 
> Since commit ecc19d17868be9c ("dmaengine: Add a warning for drivers
> not using the generic slave caps retrieval") I am getting the
> following warning on mx6:
> 
> [    0.113023] ------------[ cut here ]------------
> [    0.113053] WARNING: CPU: 0 PID: 1 at drivers/dma/dmaengine.c:830
> dma_async_device_register+0x2a0/0x4c8()
> [    0.113063] this driver doesn't support generic slave capabilities reporting
> [    0.113073] Modules linked in:
> [    0.113094] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 3.19.0-rc1-next-20141226 #2297
> [    0.113104] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> 
> What dma driver could I take as an example to implement this generic
> slave capabilities reporting?

Any of the recent ones will do: sun6i, bcm2835, at_xdmac for example.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/2315fc59/attachment.sig>
