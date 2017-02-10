From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Feb 2017 09:42:13 +0100
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Switch AXP20x driver from
 module to built-in
In-Reply-To: <49ad3e66452bd78da7b9e581129f76633c56e609.1486590875.git.rask@formelder.dk>
References: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
 <49ad3e66452bd78da7b9e581129f76633c56e609.1486590875.git.rask@formelder.dk>
Message-ID: <20170210084213.uzf25soh7bl73a6g@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 11:09:31PM +0100, Rask Ingemann Lambertsen wrote:
> The AXP20X regulator support is currently built as a module, which means
> it's not available until the root fs has been mounted, but the boot loader
> might not have enabled the required regulators, so build their drivers
> into the kernel.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/98211d4e/attachment.sig>
