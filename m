From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Sep 2012 13:53:28 +0900
Subject: [GIT PULL] Renesas ARM-based SoC fix for v3.6 #2
In-Reply-To: <20120905044441.GD6747@quad.lixom.net>
References: <1346808893-14124-1-git-send-email-horms@verge.net.au>
 <20120905044441.GD6747@quad.lixom.net>
Message-ID: <20120905045326.GA24040@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 09:44:41PM -0700, Olof Johansson wrote:
> On Wed, Sep 05, 2012 at 10:34:50AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > please consider the following fixes for the Armadillo800 EVA and
> > Mackerel boards from Morimoto-san.
> > 
> > * "ARM: shmobile: armadillo800eva: fixup: sound card detection order"
> >   is a regression fix.
> > * "ARM: shmobile: mackerel: fixup usb module order"
> >   is a regression fix.
> > * "ARM: shmobile: armadillo800eva: enable rw rootfs mount"
> >   is a boot-loader compatibility fix.
> > 
> > All of the changes are aimed at improving the end-user experience.
> > 
> > Notes:
> > 
> > * This pull request is based on my previous
> >   "[GIT PULL] Renesas ARM-based SoC fix for v3.6" pull request
> >   which was recently pulled by Olof. Please let me know
> >   if you would like me to handle this a different way.
> 
> That's exactly the way to do it. In this case it meant I have two pulls
> after each other from the same tree, and I suppose I could replace the
> older one with the newer one but that means rebasing so I just pulled it
> in. Either way, you just need to send a delta pull request like you did,
> the rest would be up to us.

Thanks, its good to know what to do.
