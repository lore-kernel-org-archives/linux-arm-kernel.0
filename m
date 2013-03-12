From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 12:48:24 +0000
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
In-Reply-To: <20130312115339.GF12700@titan.lakedaemon.net>
References: <20130312144714.39749c5b0bd1aea14c4d2ff8@canb.auug.org.au>
 <CAOesGMgSzn+uCVEMKZgtorcNkdzzvntmnfoej5vN-AjF43pnyQ@mail.gmail.com>
 <20130312115339.GF12700@titan.lakedaemon.net>
Message-ID: <201303121248.24736.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Jason Cooper wrote:
> I chose to keep them together to maintain bisectability.  Either you
> have all of the fix (you landed on this branch), or you don't.  Was this
> the correct decision in this case, or did I miss something?

I think you don't need to worry about bisection in this case, especially
as you mentioned that 3.8 is already broken.

>From all I can tell, these are four separate fixes, and you want to have
all of them get merged, but applying just one of them will not make the
state of the kernel tree any worse than what it is before the patches.

	Arnd
