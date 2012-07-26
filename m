From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 26 Jul 2012 16:10:22 -0700
Subject: [GIT PULL 00/15] arm-soc: changes for v3.6
In-Reply-To: <alpine.DEB.2.00.1207241436570.10781@utopia.booyaka.com>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
 <CA+55aFyObNFgsaVOsjVOcH+aLjDyOgcqpvckM29T3dvugekVwg@mail.gmail.com>
 <201207240751.39111.arnd@arndb.de>
 <alpine.DEB.2.00.1207241436570.10781@utopia.booyaka.com>
Message-ID: <20120726231022.GC20413@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 02:51:35PM -0600, Paul Walmsley wrote:
> Hi
> 
> On Tue, 24 Jul 2012, Arnd Bergmann wrote:
> 
> > On Tuesday 24 July 2012, Linus Torvalds wrote:
> > 
> > > In your "for-linus" branch, "&mpu_3xxx_clkdm" remains in the
> > > clockdomains_common[] array. In my merge, it is gone. But I think I
> > > did the merge correctly, and you did it wrong. HOWEVER, I don't know
> > > the code, maybe there is some subtle reason why you did it like you
> > > did.
> > 
> > Yes, I think you are right now that I look at it again. Paul Walmsley
> > can have another look at the merge and send an update if we are both
> > missing something now.
> 
> Linus' merge is correct.

FWIW, it looks right to me too.

Thanks,

Mark
