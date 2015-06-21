From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 21 Jun 2015 17:36:04 +0200
Subject: [PATCH v7 00/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <20150621082717.GA29128@gondor.apana.org.au>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150619142444.GA15234@gondor.apana.org.au>
 <CAP=VYLqQynCNRTpm4JnOxeO6DH_739fO2QNcDMxaXqCKCHiTtQ@mail.gmail.com>
 <CAP=VYLpSrTvXRovWo4G7AXWv1OKFQRpQR255hS5z+=h4+XOLhg@mail.gmail.com>
 <20150621102418.2ea74910@bbrezillon>
 <20150621082717.GA29128@gondor.apana.org.au>
Message-ID: <20150621173604.04cc4087@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Sun, 21 Jun 2015 16:27:17 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Sun, Jun 21, 2015 at 10:24:18AM +0200, Boris Brezillon wrote:
> > 
> > Indeed. Here is a patch fixing that.
> 
> I think you should just kill COMPILE_TEST instead of adding ARM.

Okay, I guess I should also kill the HAS_DMA and HAS_IOMEM since
PLAT_ORION and ARCH_MVEBU are guaranteed to have those options selected.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
