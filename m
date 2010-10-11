From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Oct 2010 12:03:38 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <b7d9a97c0eda73281b49c9a7744f5569@cox.rootnode.net>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<20101009002546.GB14675@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010082210150.3107@xanadu.home>
	<1286791544.19739.31.camel@e102109-lin.cambridge.arm.com>
	<b7d9a97c0eda73281b49c9a7744f5569@cox.rootnode.net>
Message-ID: <1286795018.19739.32.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-11 at 12:01 +0100, Pawel Moll wrote:
> > +                 (mtype != MT_DEVICE_CACHED || mtype != MT_DEVICE_WC))
> 
> Em, am I wrong or this expression _always_ evaluates as 1? ;-)

Should be '&&'. Thanks.

-- 
Catalin
