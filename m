From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 9 Aug 2010 12:50:49 +0200
Subject: [PATCH 2/2] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTi=9BjWWdcZg0w772jcemjriQ5p0HV3EJB8OM68O@mail.gmail.com>
References: <1277811391-17966-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=jStVGbJC7jUyhOG3og14F58rw+LEN2UqnP-X0@mail.gmail.com>
	<AANLkTi=bkp+JJYQ7dF36Up3gcjJR8LypgfKBWZHLfPH-@mail.gmail.com>
	<AANLkTimPAeupEKwksBKOyWX8K+wHgmgc5vEJ8cXBsQtD@mail.gmail.com>
	<AANLkTi=yJjHDh08muCg7Z97xRGDcTQrv=VimHSNCqn2U@mail.gmail.com>
	<20100805071235.GA436@morgana.i.gnudd.com>
	<AANLkTinAuZ5GAauKHfUVV_K_9gQOpFY35m7SLsH6rvD1@mail.gmail.com>
	<AANLkTi=OLP+NwGP7v0O0=ZqBNp_Ag9mm+LEUnCw5OX7L@mail.gmail.com>
	<AANLkTi=9BjWWdcZg0w772jcemjriQ5p0HV3EJB8OM68O@mail.gmail.com>
Message-ID: <AANLkTinmxFywsekEtwOm_YFM1u1D5R_LhO+GVAfi6+fy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/6 Dan Williams <dan.j.williams@intel.com>:

> ...except this version no longer compiles:

Hm the v3 version works fine with me, but anyway, I mailed out a v4
that also removes the unneeded mb() macros.

> Fix that up and we can try to get it in the second half of the merge window.

Great, thanks.

I'll work on getting this in place to run with the PrimeCell extensions
and proof-of-concept for ARM RealView reference designs next.

Yours,
Linus Walleij
