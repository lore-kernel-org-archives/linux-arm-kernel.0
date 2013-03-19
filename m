From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 19 Mar 2013 08:25:15 -0300
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <51483960.3030903@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
 <20130319100352.GB2419@localhost> <51483960.3030903@keymile.com>
Message-ID: <20130319112514.GC3137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:09:36AM +0100, Gerlando Falauto wrote:
> 
> thanks for the information!
> 

You're welcome :-)

> > Stable people will take care of picking the patch when it hits
> > mainline. You should receive a mail notification about patches
> > being included in stable kernels.
> 
> Thank you so much. I guess I'd rather have to wait for Thomas' blessing 
> first (maybe in the form of an Acked-By), don't I?
> 

AFAIK no, you don't have to wait for Thomas.

The stable rules are like this:
You submit a patch you think it applies for stable (see Documentation/stable_kernel_rules)
adding a 'Cc: stable at vger.kernel.org' tag. If the suitable maintainer accepts the patch,
it will eventually get merged, and when it hits mainline, the stable tag will tell stable
people to add this patch into their trees (anyone please correct me if I'm wrong).

As Jason suggests, you should also state which commit is your patch fixing.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
