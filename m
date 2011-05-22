From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 22 May 2011 17:52:57 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <201105212245.02561.morpheus.ibis@gmail.com>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110521202806.GA3518@elf.ucw.cz>
	<201105212245.02561.morpheus.ibis@gmail.com>
Message-ID: <201105221752.57784.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, May 21, 2011 10:45:02 PM Pavel Herrmann wrote:
> On Saturday, May 21, 2011 10:28:07 PM Pavel Machek wrote:
> > Unfortunately that one does not apply, due to
> > 
> > > @@ -213,6 +224,7 @@ static int __devexit max1111_remove(struct
> > > spi_device *spi)
> > 
> > Whitespace damage. (but if you just delete this extra newline, its
> > fine).
> 
> sorry for that one, I followed Mareks advice on sending the pach inline,
> and my mail client does automatic text reflow (defaults to 78 columns). I
> still have to find the correct formating settings to send these patches.
> 
> thanks for the ACK and testing
> 
> Pavel

Use git send-email, I recall telling you this ;-)
