From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2009 00:00:08 +0100
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <200909132328.47079.marek.vasut@gmail.com>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<200909132328.47079.marek.vasut@gmail.com>
Message-ID: <20090913230008.GC30169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2009 at 11:28:47PM +0200, Marek Vasut wrote:
> >  		bhi	__delay
> >  		mov	pc, lr
> >  ENDPROC(__udelay)
> > 
> Hi
> 
> why was this code there in the first place ?

To make the delay loop more stable and predictable on older CPUs.
