From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 7 Aug 2010 00:54:59 +0200
Subject: [PATCH 2/2] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTi=OLP+NwGP7v0O0=ZqBNp_Ag9mm+LEUnCw5OX7L@mail.gmail.com>
References: <1277811391-17966-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=jStVGbJC7jUyhOG3og14F58rw+LEN2UqnP-X0@mail.gmail.com>
	<AANLkTi=bkp+JJYQ7dF36Up3gcjJR8LypgfKBWZHLfPH-@mail.gmail.com>
	<AANLkTimPAeupEKwksBKOyWX8K+wHgmgc5vEJ8cXBsQtD@mail.gmail.com>
	<AANLkTi=yJjHDh08muCg7Z97xRGDcTQrv=VimHSNCqn2U@mail.gmail.com>
	<20100805071235.GA436@morgana.i.gnudd.com>
	<AANLkTinAuZ5GAauKHfUVV_K_9gQOpFY35m7SLsH6rvD1@mail.gmail.com>
	<AANLkTi=OLP+NwGP7v0O0=ZqBNp_Ag9mm+LEUnCw5OX7L@mail.gmail.com>
Message-ID: <AANLkTiki_69rgDCrMGtYwNmsp35EYiUedbLnYM_dvv+a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/6 Dan Williams <dan.j.williams@intel.com>:

>?One
> thing that should be on the todo list is to review the usage of memory
> barriers. ?I don't think they are serving the purpose that you think
> they are.

All of those are from Peters original implementation, I never use any
barriers so they actually looked alien to me. Unless I get a clear
rationale from Peter I'll just remove them all for the time being in
the fix-up version due after updating to generic slave control.

Yours,
Linus Walleij
