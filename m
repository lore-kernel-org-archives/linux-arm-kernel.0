From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Jul 2018 16:03:08 +0100
Subject: next/master boot: 184 boots: 13 failed, 171 passed (next-20180711)
In-Reply-To: <5b45f6df.1c69fb81.86409.6375@mx.google.com>
References: <5b45f6df.1c69fb81.86409.6375@mx.google.com>
Message-ID: <20180711150308.GB9651@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 05:23:59AM -0700, kernelci.org bot wrote:

Today's -next fails to boot on a bunch of sunxi platforms  

>     sunxi_defconfig:
>         sun4i-a10-cubieboard:
>             lab-baylibre-seattle: new failure (last pass: next-20180710)
>         sun7i-a20-bananapi:
>             lab-baylibre-seattle: new failure (last pass: next-20180710)
>         sun7i-a20-cubietruck:
>             lab-baylibre-seattle: new failure (last pass: next-20180710)

multi_v7_defconfig seems fine.  It seems to get into userspace but not
far enough to get to a prompt, the failure seems similar on all the
platforms, full logs and other information can be found here:

    https://kernelci.org/boot/id/5b45cfd759b514f3e696ba93/
    https://kernelci.org/boot/id/5b45cfda59b514f41a96ba8f/
    https://kernelci.org/boot/id/5b45cfdd59b514f41796ba8e/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/a9e0bae0/attachment-0001.sig>
