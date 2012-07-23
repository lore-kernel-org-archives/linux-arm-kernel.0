From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Jul 2012 09:27:49 +0200
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120722224241.GH4557@opensource.wolfsonmicro.com>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
Message-ID: <20120723072749.GA18778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 11:42:57PM +0100, Mark Brown wrote:
> On Sun, Jul 22, 2012 at 09:32:43PM +0200, Andrew Lunn wrote:
> > On Sun, Jul 22, 2012 at 08:07:01PM +0100, Mark Brown wrote:
> 
> > > Well, I'd like to think that generally I'm reasonably responsive to
> > > patch submissions 
> 
> > Well, this particular patch was first submitted May 19th and Ack-by
> > Linus on May 14th.
> 
> > http://comments.gmane.org/gmane.linux.kernel.spi.devel/9937
> 
> > It was reposted 10 Jun and Acked-by again in Jun 10 by Linus.
> 
> > It was also reposted July 3.
> 
> None of which were CCed to me; they were all before I started looking
> after SPI so that's not surprising but still the number of reposts is
> more a comment on why I'm helping out here than on what I said above.

Hi Mark

O.K., fair enough.

Will you accept any patches for this merge window? As you said, the DT
enablement is low risk. It should be possible to separate this one
patch from the other two.

https://github.com/lunn/linux/commit/794e259e3e23f02250ac12c74dd507a4b340b257

      Andrew
