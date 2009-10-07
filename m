From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 7 Oct 2009 09:56:42 +0200
Subject: ucb1x00 patches
In-Reply-To: <19148.16274.293527.828860@ipc1.ka-ro>
References: <4ACB7123.8000609@gmx.de> <19148.16274.293527.828860@ipc1.ka-ro>
Message-ID: <200910070956.42651.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 7. ??jna 2009 09:13:22 Lothar Wa?mann napsal(a):
> Hi,
> 
> Thomas Kunze writes:
> > Hi,
> >
> > I posted these patches at linux-arm-kernel as part of the patchset
> > "collie and SA1100 patches".
> > Could you please comment on them? I'd also like to know you opinion on
> > moving ucb1x00-ts.c to
> > input/drivers/touchscreen.
> 
> What about the ucb1400_ts.c which is already there?
> 

I'd be for unifying all the ucb drivers into a single one, but Russell was 
against it iirc.
> 
> Lothar Wa?mann
> 
