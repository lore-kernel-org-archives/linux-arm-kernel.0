From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 19 Jun 2015 22:03:15 +0800
Subject: [PATCH v7 04/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <5583D56F.7020808@free-electrons.com>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434635190-27733-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150619064256.GA10246@gondor.apana.org.au>
 <20150619102407.01187ff0@free-electrons.com>
 <5583D56F.7020808@free-electrons.com>
Message-ID: <20150619140315.GA14692@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 10:40:15AM +0200, Gregory CLEMENT wrote:
> 
> For this option you can use the branch mvebu/drivers located at
>  git://git.infradead.org/linux-mvebu.git.
> 
> In this branch there is the commit "bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()"
> but not only this one because it depends also on fixes which have been
> merged in this same branch.

It looks like the parent of this changeset is already in the mainline
so it's literally just a single patch.  I'll try to pull it into
cryptodev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
