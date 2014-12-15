From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Dec 2014 10:25:54 +0000
Subject: request bitrev patch merge
In-Reply-To: <20141215095239.GB11285@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103EDAF89E146@CNBJMBX05.corpusers.net>
 <20141215095239.GB11285@n2100.arm.linux.org.uk>
Message-ID: <20141215102554.GC11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 09:52:39AM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 15, 2014 at 02:02:50PM +0800, Wang, Yalin wrote:
> > Hi
> > 
> > Joe's patch that remove use byte_rev_table directly have
> > Been merged into linux-next branch ,
> > Cou you merge 8187/1 8205/1 8189/1 patch for arm ?
> 
> Unfortunately, it's missed this merge window.  It is bad practice to add
> new features to linux-next during a merge window, and it is also bad to
> send new features to Linus without them having been in linux-next before
> the merge window opened.
> 
> It will be queued for -rc1.

I mean, it will be queued /after/ -rc1.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
