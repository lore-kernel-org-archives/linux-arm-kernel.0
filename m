From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Jan 2012 13:27:41 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120130114131.GC15596@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <4F267F21.1030204@freescale.com> <20120130114131.GC15596@pengutronix.de>
Message-ID: <201201301327.41298.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> CCing Marek, he can say more about the U-Boot side probably...

Thanks!

> 
> > > Bootloaders may also need to write to NAND. So, they need to share the
> > 
> > Do you mean the uboot may write something to the NAND?
> > Could you show me some more detail cases?
> 
> U-Boot has NAND support in mainline, for barebox it is work-in-progress.

Why don't you rather start hacking on u-boot instead of chasing behind it all 
the time ;-)

> Both can and do write to NAND (kernel, rootfs), because both have
> established procedures to do so (and maybe don't want to rely on
> third-party tools like kobs-ng).

I think the FSL U-Boot can write stuff to NAND too. You can give that a shot 
too.
> 
> > > share the same information then. To be on the safe side regardings
> > 
> > The kobs-ng which burns the bootloader to the NAND will also burn the
> > whole BBT
> > to the NAND too.
> 
> Did it always do that? Or is a newer version needed?

I can't comment on this one, I never used it. I rather got NAND working 
properly.

> 
> > But if the bootloader can make some block bad, the BBT information
> > becomes different.
> > Does the bootloader have the feature to make some block bad?
> 
> Sure. If you are able to write NAND, you should be able to mark blocks
> bad, too :)

Not really, but you prefer to do so ;-)

Thanks!

M
> 
> Thanks,
> 
>    Wolfram
