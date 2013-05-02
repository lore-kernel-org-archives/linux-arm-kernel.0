From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 2 May 2013 12:04:46 +0100
Subject: [Xen-devel] [PATCH 3/3] xen/arm: account for stolen ticks
In-Reply-To: <1367492533.21869.81.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <1367482862.21869.28.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1305021134160.5398@kaball.uk.xensource.com>
 <1367491708.21869.77.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1305021153220.5398@kaball.uk.xensource.com>
 <1367492533.21869.81.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1305021204050.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 May 2013, Ian Campbell wrote:
> > > > It's based on my 3.9-rc3-smp-6 branch currently in linux-next (that is
> > > > based on 3.9-rc3).
> > > > However lost_ticks_1 is not in linux-next yet.
> > > 
> > > Which branch is in Linux next? It doesn't seem to be your linux-next
> > > (last commit 2011).
> > 
> > that would be linux-next from
> > git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git
> 
> Ah, I was looking in your xenbits tree -- is that deprecated?

I guess it is, now that I have a kernel.org account.
I might as well get rid of it.
