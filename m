From: olof@lixom.net (Olof Johansson)
Date: Tue, 9 Oct 2012 14:26:39 -0700
Subject: [PATCH 0/3] new ARM-soc warning fixes
In-Reply-To: <201210092001.26947.arnd@arndb.de>
References: <1349796861-31164-1-git-send-email-arnd@arndb.de>
 <20121009174631.GA19606@quad.lixom.net>
 <201210092001.26947.arnd@arndb.de>
Message-ID: <20121009212639.GA25765@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 08:01:26PM +0000, Arnd Bergmann wrote:
> On Tuesday 09 October 2012, Olof Johansson wrote:
> > On Tue, Oct 09, 2012 at 05:34:18PM +0200, Arnd Bergmann wrote:
> > > Hi Olof,
> > > 
> > > Here are three more fixes that I'd like to merge through the arm-soc
> > > as time permits. All of them should be completely harmless and they
> > > only fix harmless gcc warnings.
> > > 
> > > I don't know what your plans are for sending the next fixes branch.
> > > I've uploaded these into a new "fixes2" branch on top of the patches
> > > that are already in "fixes". We can either send them all together,
> > > or you send the ones that are already queued first and these ones
> > > with the next batch. Feel free to rebase if necessary.
> > 
> > I've pulled it in and will send up with fixes tonight (Tony has OMAP
> > fixes coming, others might too).
> > 
> 
> Ok, thanks!
> 
> I just noticed that I was missing yet another one, which I now added
> directly. It was part of a longer series I sent last week. I wasn't
> really sure whether this one would better be included in arm-soc or
> Russell's arm tree and then I ended up not putting it in either series :(

OK, I applied on top of the rest.


-Olof
