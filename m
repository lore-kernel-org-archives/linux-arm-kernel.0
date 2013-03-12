From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 12 Mar 2013 09:32:25 -0400
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
In-Reply-To: <201303121248.24736.arnd@arndb.de>
References: <20130312144714.39749c5b0bd1aea14c4d2ff8@canb.auug.org.au>
 <CAOesGMgSzn+uCVEMKZgtorcNkdzzvntmnfoej5vN-AjF43pnyQ@mail.gmail.com>
 <20130312115339.GF12700@titan.lakedaemon.net>
 <201303121248.24736.arnd@arndb.de>
Message-ID: <20130312133225.GG12700@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 12:48:24PM +0000, Arnd Bergmann wrote:
> On Tuesday 12 March 2013, Jason Cooper wrote:
> > I chose to keep them together to maintain bisectability.  Either you
> > have all of the fix (you landed on this branch), or you don't.  Was this
> > the correct decision in this case, or did I miss something?
> 
> I think you don't need to worry about bisection in this case, especially
> as you mentioned that 3.8 is already broken.
> 
> From all I can tell, these are four separate fixes, and you want to have
> all of them get merged, but applying just one of them will not make the
> state of the kernel tree any worse than what it is before the patches.

Ok, thanks for the clarification.  I'll ease up on the bisectability
requirement for fixes in the future.

thx,

Jason.
