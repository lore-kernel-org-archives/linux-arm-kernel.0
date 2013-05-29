From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 29 May 2013 14:16:56 -0400 (EDT)
Subject: [PATCH V8 0/3] USB: OHCI: Start splitting up the driver
In-Reply-To: <3818608.3TBO8NnpYQ@wuerfel>
Message-ID: <Pine.LNX.4.44L0.1305291415150.885-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Arnd Bergmann wrote:

> On Wednesday 29 May 2013 12:21:02 Alan Stern wrote:
> > 
> > Those error messages are annoying; they don't use dev_err(), so they
> > don't include the device and driver names.  There's no way to know what
> > they refer to.  I rather suspect they come from the usbaudio driver.
> 
> That makes sense. I have a usb audio device, and I don't actually recall
> getting any sound from my speakers while testing it. I only checked
> that the mouse was working and assumed that the usb-audio was driven
> by ehci, but upon closer inspection, they are both on the same OHCI.
> 
> > When you ran this test, did you have commit 815fa7b91761 applied?
> 
> Yes.
> 
> > Does the same problem occur without Manjunath's changes?
> 
> No, it was introduced by the first patch, as I found later.

I'll try to replicate your result.  I don't have my USB audio device 
here today, so it will have to wait until tomorrow.

Alan Stern
