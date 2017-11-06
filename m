From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Nov 2017 19:26:46 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
Message-ID: <20171106192646.zr5drltyaerznfso@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 04:30:41AM -0800, kernelci.org bot wrote:

> Full Boot Summary: https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20171106/
> Full Build Summary: https://kernelci.org/build/next/branch/master/kernel/next-20171106/

Today's -next failed to boot sun8i-a83t-allwinner-h8homlet-v2 with
sunxi_defconfig (it *did* boot with multi_v7_defconfig):

>     sunxi_defconfig:
>         sun8i-a83t-allwinner-h8homlet-v2:
>             lab-free-electrons: new failure (last pass: next-20171103)

Logs and comparisons with other trees can be seen here:

   https://kernelci.org/boot/id/5a00271d59b514a38b1cdd21/

Looks like it locked up at some point.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171106/630c2114/attachment.sig>
