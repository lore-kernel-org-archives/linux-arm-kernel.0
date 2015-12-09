From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 9 Dec 2015 16:44:58 +0800
Subject: [PATCH v2 0/3] dmaengine: Add supports for APM X-Gene SoC CRC32C
 accerlerator driver
In-Reply-To: <CAFd313z3zaXMAgKWa9KwQw1QxU4LuW_uoAz5_=42viYk2zaaOA@mail.gmail.com>
References: <rsahu@apm.com> <1447665169-14003-1-git-send-email-rsahu@apm.com>
 <CAFd313yzBgWhTD2+Lz+RsdziAuc2kdZPS1L2FExET5sLirs_DQ@mail.gmail.com>
 <20151209082748.GA26696@gondor.apana.org.au>
 <CAFd313z3zaXMAgKWa9KwQw1QxU4LuW_uoAz5_=42viYk2zaaOA@mail.gmail.com>
Message-ID: <20151209084458.GA26803@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 02:13:32PM +0530, Rameshwar Sahu wrote:
>
> Yes, we are not upstream in-kernel users right now, but later client
> ma upstream there patches.

Well I'd prefer to not take any crypto drivers that don't have
in-kernel users.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
