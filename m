From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 17 May 2015 18:34:40 +0800
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150517104508.468b032f@bbrezillon>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon>
Message-ID: <20150517103440.GA7800@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 17, 2015 at 10:45:08AM +0200, Boris Brezillon wrote:
>
> From my POV this is not asynchronous at all (see my comments inline),
> but maybe Herbert can confirm that.

Well we don't actually require drivers to be asynchronous.  It is
obviously the preferred method but some hardware may not be capable
of that.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
