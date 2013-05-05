From: bp@alien8.de (Borislav Petkov)
Date: Sun, 5 May 2013 14:36:33 +0200
Subject: [PATCH v4 0/7] enable support for AMBA drivers under x86
In-Reply-To: <20121213181449.GA15966@mail.gnudd.com>
References: <50C93A83.8040106@zytor.com>
 <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <50C93718.2090706@zytor.com>
 <20121213181449.GA15966@mail.gnudd.com>
Message-ID: <20130505123633.GA14095@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 07:14:49PM +0100, Alessandro Rubini wrote:
> This is a long-standing problem, but with not practical effects. I
> proposed a pair of different fixes quite some months ago. I'll respin
> the problem tomorrow.

Did this got fixed in some tree in the meantime? Because I still see it on
current Linus + tip/master:

arch/x86/pci/sta2x11-fixup.c:186:2: warning: initialization from incompatible pointer type [enabled by default]
arch/x86/pci/sta2x11-fixup.c:186:2: warning: (near initialization for ?sta2x11_dma_ops.free?) [enabled by default]

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
