From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Nov 2017 19:17:13 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
Message-ID: <20171106191713.d7jqg2b6zqchythw@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 04:30:41AM -0800, kernelci.org bot wrote:

> Full Boot Summary:
https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20171106/
> Full Build Summary: https://kernelci.org/build/next/branch/master/kernel/next-20171106/

Since Friday -next has been failing to boot tegra124-nyan-big in
kernelci with all configs:

> arm:

>     multi_v7_defconfig:
>         tegra124-nyan-big:
>             lab-collabora: failing since 2 days (last pass: next-20171102 - first fail: next-20171103)

It's fine in mainline, see: 

    https://kernelci.org/boot/id/5a0030c959b514aad21cdd1a/

for boot log, history and comparisons with other trees.  Looks like
output started grinding to a halt at the point where it starts
requesting firmware but ICBW.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171106/bf1ae8aa/attachment.sig>
