From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 22 Jan 2013 10:30:10 -0500 (EST)
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <20130122061116.GD29677@S2100-06.ap.freescale.net>
Message-ID: <Pine.LNX.4.44L0.1301221028580.1510-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013, Shawn Guo wrote:

> On Mon, Jan 21, 2013 at 09:37:42PM +0000, Arnd Bergmann wrote:
> > > Arnd, please take a look at
> > > 
> > >         http://marc.info/?l=linux-usb&amp;m=135843716515529&amp;w=2
> > > 
> > > I can't test it easily, not being set up for cross compilation.  I'm 
> > > waiting to hear from anybody whether it works before submitting it.
> > > (There's also a report of memory corruption involving a similar patch 
> > > for ehci-omap; it hasn't been tracked down yet.)
> > 
> > Your patch looks good to me, but it also seems to do some other
> > changes that are not required to fix the problem but could wait
> > for 3.9 instead. You definitely have my Ack if you are willing
> > to take it for 3.8 though.

I think it's not too late to submit this for 3.8.  Thanks for the Ack.

> > Shawn or Sascha should be able to test it.
> > 
> Alan,
> 
> Thanks for the patch.  I just gave it try.  The USB Host port still
> works for me with a couple of fixes on your changes integrated (one
> for compiling and the other for probing).  So you have my ACK with
> the changes below rolled into your patch.

Right, I have merged your changes into the patch.  Will submit shortly.

Alan Stern
