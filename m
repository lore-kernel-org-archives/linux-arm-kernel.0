From: Baohua.Song@csr.com (Barry Song)
Date: Wed, 24 Aug 2011 07:43:29 +0000
Subject: [PATCH 2/2] ARM: mach-ux500: add explicit cpu_relax() for busy
	wait loop
In-Reply-To: <CACRpkdY_JerDkSRPTLt8KJj1TmZHHAc4RhEOR3X-mjB-VVSjtw@mail.gmail.com>
References: <1314149486-5105-1-git-send-email-Baohua.Song@csr.com>
	<CACRpkdY_JerDkSRPTLt8KJj1TmZHHAc4RhEOR3X-mjB-VVSjtw@mail.gmail.com>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E937BD836D@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > using cpu_relax in busy loops is a well-known idiom in the kernel. It's more
> > for documentation purposes than technically needed here.
> >
> > Cc: Jamie Iles <jamie@jamieiles.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Do you want me to push this to the ux500 tree or will
> you feed it in some other way?


Linus, better push it to ux500 and Arnd pull your ux500.

> 
> Thanks!
> Linus Walleij

-barry


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
