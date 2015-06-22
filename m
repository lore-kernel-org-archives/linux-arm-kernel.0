From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 22 Jun 2015 15:59:10 +0800
Subject: [PATCH v7 00/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <20150622092336.5949e258@bbrezillon>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150619142444.GA15234@gondor.apana.org.au>
 <CAP=VYLqQynCNRTpm4JnOxeO6DH_739fO2QNcDMxaXqCKCHiTtQ@mail.gmail.com>
 <CAP=VYLpSrTvXRovWo4G7AXWv1OKFQRpQR255hS5z+=h4+XOLhg@mail.gmail.com>
 <20150621102418.2ea74910@bbrezillon>
 <20150621082717.GA29128@gondor.apana.org.au>
 <20150622092336.5949e258@bbrezillon>
Message-ID: <20150622075910.GA7659@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 09:23:36AM +0200, Boris Brezillon wrote:
> Hi Herbert,
> 
> On Sun, 21 Jun 2015 16:27:17 +0800
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > On Sun, Jun 21, 2015 at 10:24:18AM +0200, Boris Brezillon wrote:
> > > 
> > > Indeed. Here is a patch fixing that.
> > 
> > I think you should just kill COMPILE_TEST instead of adding ARM.
> 
> The following patch is killing the COMPILE_TEST dependency.

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
