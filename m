From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 16 Dec 2015 11:12:31 +0000
Subject: arm-soc boot: 320 boots: 12 failed, 308 passed
 (v4.4-rc3-483-gb48b5ceb7227)
In-Reply-To: <1746045.ErmxH37Pke@wuerfel>
References: <567128b4.46b71c0a.17f65.7531@mx.google.com>
 <1746045.ErmxH37Pke@wuerfel>
Message-ID: <1450264351.2819.4.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-16 at 11:17 +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 01:02:44 kernelci. org bot wrote:
> > arm-soc boot: 320 boots: 12 failed, 308 passed (v4.4-rc3-483-gb48b5ceb7227)
> > 
> > Full Boot Summary: https://kernelci.org/boot/all/job/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb7227/
> > Full Build Summary: https://kernelci.org/build/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb7227/
> > 
> >
[...]
> * Juno seems to be sick and doesn't like LAVA today:

Looks like a LAVA hickup, I downloaded the Image and btb and they appear
to work fine on my board. Just to make sure I was running the right
kernel...

# uname -a
Linux genericarmv8 4.4.0-rc3+ #1 SMP PREEMPT Wed Dec 16 05:51:25 CET 2015 aarch64 GNU/Linux

-- 
Tixy
