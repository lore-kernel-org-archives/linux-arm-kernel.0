From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Oct 2011 10:23:43 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111017082506.GC21648@n2100.arm.linux.org.uk>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
	<20111011184821.GA11839@mudshark.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<20111017082506.GC21648@n2100.arm.linux.org.uk>
Message-ID: <20111017092342.GB2459@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 09:25:06AM +0100, Russell King - ARM Linux wrote:
> The only thing I can do to keep stuff independent is to rebuild the
> 'misc' branch into a pair of proper topic branches (debug and smp)
> and push those out (done).
> 
> Note that these are based on the same commit as the original 'misc'
> branch so that I can verify that what we ultimately end up with
> after the topic merges is identical to what we had before (it is.)

Thanks for doing this Russell. Arnd, I've made two new branches based on the
above at:

git://github.com/wdeacon/linux-wd.git cpu-mapping-for-arnd

git://github.com/wdeacon/linux-wd.git debug-ll-for-arnd

Will
