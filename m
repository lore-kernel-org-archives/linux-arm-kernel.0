From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Feb 2017 09:41:25 +0100
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Switch sunxi RSB driver
 from module to built-in
In-Reply-To: <870393c080135a968b9c0d9e78e3009fb32593f3.1486590875.git.rask@formelder.dk>
References: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
 <870393c080135a968b9c0d9e78e3009fb32593f3.1486590875.git.rask@formelder.dk>
Message-ID: <20170210084125.hts7qj2q3lplvk4m@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 11:08:00PM +0100, Rask Ingemann Lambertsen wrote:
> The sunxi RSB bus is used for peripherals like voltage regulators and
> real-time clocks which should be available early in the boot process.
> As a module, the driver will not be available until the root fs has been
> mounted, so build the driver into the kernel.
> 
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>

Queued for 4.12.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/307b6909/attachment.sig>
