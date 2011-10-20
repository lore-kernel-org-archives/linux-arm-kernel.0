From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 16:57:49 +0200
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111017092342.GB2459@mudshark.cambridge.arm.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111017082506.GC21648@n2100.arm.linux.org.uk>
	<20111017092342.GB2459@mudshark.cambridge.arm.com>
Message-ID: <201110201657.51810.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 October 2011, Will Deacon wrote:
> On Mon, Oct 17, 2011 at 09:25:06AM +0100, Russell King - ARM Linux wrote:
> > The only thing I can do to keep stuff independent is to rebuild the
> > 'misc' branch into a pair of proper topic branches (debug and smp)
> > and push those out (done).
> > 
> > Note that these are based on the same commit as the original 'misc'
> > branch so that I can verify that what we ultimately end up with
> > after the topic merges is identical to what we had before (it is.)
> 
> Thanks for doing this Russell. Arnd, I've made two new branches based on the
> above at:
> 
> git://github.com/wdeacon/linux-wd.git cpu-mapping-for-arnd
> 
> git://github.com/wdeacon/linux-wd.git debug-ll-for-arnd

Ok, thanks a lot. I've updated my branches now and recreated
the for-next branch with these. Can you have a look to make sure
that everything looks good there now?

	Arnd
