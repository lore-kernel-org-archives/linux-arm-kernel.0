From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 11 Sep 2018 11:01:32 +0200
Subject: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
In-Reply-To: <20180911084548.GC4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell> <20180911084548.GC4185@dell>
Message-ID: <20180911090132.GB25161@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
> On Mon, 10 Sep 2018, Lee Jones wrote:
> 
> > Enjoy!
> > 
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > 
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> > 
> > for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> > 
> >   tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
> 
> Due to a comedy of errors, I'm voiding this pull-request.

Um, I can't do that as my tree can not be rebased :(

I can take follow-on patches, so I will go apply the patch posted so
that my tree builds again.  I recommend you just apply it as well.

thanks,

greg k-h
