From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Sep 2010 18:13:49 +0100
Subject: [PATCH] ARM: kprobes-decode: add support for MOVW instruction
In-Reply-To: <alpine.LFD.2.00.1009271301050.1146@xanadu.home>
References: <1285170122-19823-1-git-send-email-will.deacon@arm.com>
	<000201cb5e46$3265b8c0$97312a40$%deacon@arm.com>
	<alpine.LFD.2.00.1009271301050.1146@xanadu.home>
Message-ID: <000901cb5e67$5a52f660$0ef8e320$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, 27 Sep 2010, Will Deacon wrote:
> 
> > > The MOVW instruction moves a 16-bit immediate into the bottom halfword
> > > of the destination register.
> > >
> > > This patch ensures that kprobes leaves the 16-bit immediate intact, rather
> > > than assume a 12-bit immediate and mask out the upper 4 bits.
> > >
> > > Cc: Nicolas Pitre <nico@fluxnic.net>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Cheers Nicolas,

Submitted as 6412/1.

Will
