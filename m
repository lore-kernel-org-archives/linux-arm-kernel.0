From: amonakov@ispras.ru (Alexander Monakov)
Date: Wed, 14 Mar 2018 10:05:09 +0300 (MSK)
Subject: [PATCH 1/8] ARM: berlin: extend BG2CD Kconfig entry
In-Reply-To: <20180314135832.0ebdeb66@xhacker.debian>
References: <20180311160008.22928-1-amonakov@ispras.ru>
 <20180311160008.22928-2-amonakov@ispras.ru>
 <20180314135832.0ebdeb66@xhacker.debian>
Message-ID: <alpine.LNX.2.20.13.1803140957380.21514@monopod.intra.ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2018, Jisheng Zhang wrote:

> > +	select PL310_ERRATA_769419
> 
> IIRC, BG2CD doesn't need this

Indeed, PL310 in BG2CD has revision r3p2 and so is not affected. My mistake.
I think I was confused because the kernel tests affected revision ranges for
other PL310 errata, but not this one (and always applies the workaround).

Thank you! Will drop this line when reposting the patch.

Alexander
