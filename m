From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 25 Jun 2015 11:13:23 +0200
Subject: [PATCH v2 1/3] net: mvneta: introduce compatible string
 "marvell, armada-xp-neta"
In-Reply-To: <20150619123253.GB4853@kw.sim.vm.gnt>
References: <1434547162-6275-1-git-send-email-simon.guinot@sequanux.org>
 <1434547162-6275-2-git-send-email-simon.guinot@sequanux.org>
 <55818E64.20007@free-electrons.com>
 <55818F10.8030304@free-electrons.com>
 <20150617170112.GD2917@io.lakedaemon.net>
 <20150619123253.GB4853@kw.sim.vm.gnt>
Message-ID: <20150625091323.GH4853@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 02:32:53PM +0200, Simon Guinot wrote:
> On Wed, Jun 17, 2015 at 05:01:12PM +0000, Jason Cooper wrote:
> > Hi Gregory,
> > 
> > On Wed, Jun 17, 2015 at 05:15:28PM +0200, Gregory CLEMENT wrote:
> > > On 17/06/2015 17:12, Gregory CLEMENT wrote:
> > > > On 17/06/2015 15:19, Simon Guinot wrote:
> > > >> The mvneta driver supports the Ethernet IP found in the Armada 370, XP,
> > > >> 380 and 385 SoCs. Since at least one more hardware feature is available
> > > >> for the Armada XP SoCs then a way to identify them is needed.
> > > >>
> > > >> This patch introduces a new compatible string "marvell,armada-xp-neta".
> > > > 
> > > > Let's be future proof by going further. I would like to have an compatible string
> > > > for each SoC even if we currently we don't use them.
> > 
> > I disagree with this.  We can't predict what incosistencies we'll discover in
> > the future.  We should only assign new compatible strings based on known IP
> > variations when we discover them.  This seems fraught with demons since we
> > can't predict the scope of affected IP blocks (some steppings of one SoC, three
> > SoCs plus two steppings of a fourth, etc)
> > 
> > imho, the 'future-proofing' lies in being specific as to the naming of the
> > compatible strings against known hardware variations at the time.
> 
> So, should I add more compatible strings or not ?

Hi Gregory and Jason,

How do you want me to handle this ? Did you reach an agreement ?

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150625/30762b36/attachment-0001.sig>
