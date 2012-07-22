From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 22 Jul 2012 21:32:43 +0200
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120722190700.GD4557@opensource.wolfsonmicro.com>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
Message-ID: <20120722193243.GF5423@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 08:07:01PM +0100, Mark Brown wrote:
> On Sun, Jul 22, 2012 at 11:53:28AM +0200, Andrew Lunn wrote:
> 
> > You can see the chain of dependencies here. So at minimum i would need
> > to send the first three via Mark. I then need to cross my fingers and
> > hope he really picks them up, because without them, we are going to
> > have a number of boards which fail to find their root file system on
> > an SPI flash.
> 
> Well, I'd like to think that generally I'm reasonably responsive to
> patch submissions 

Well, this particular patch was first submitted May 19th and Ack-by
Linus on May 14th.

http://comments.gmane.org/gmane.linux.kernel.spi.devel/9937

It was reposted 10 Jun and Acked-by again in Jun 10 by Linus.

It was also reposted July 3.

   Andrew
