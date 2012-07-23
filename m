From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Jul 2012 13:02:27 +0200
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <500D2D42.3000006@mvista.com>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch> <500D2D42.3000006@mvista.com>
Message-ID: <20120723110227.GI18778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 02:53:54PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 22-07-2012 23:32, Andrew Lunn wrote:
> 
> >>>You can see the chain of dependencies here. So at minimum i would need
> >>>to send the first three via Mark. I then need to cross my fingers and
> >>>hope he really picks them up, because without them, we are going to
> >>>have a number of boards which fail to find their root file system on
> >>>an SPI flash.
> 
> >>Well, I'd like to think that generally I'm reasonably responsive to
> >>patch submissions
> 
> >Well, this particular patch was first submitted May 19th and Ack-by
> >Linus on May 14th.
> 
>    It was acked even before submitted? ;-)

I have my dates wrong. See:

http://comments.gmane.org/gmane.linux.kernel.spi.devel/9937

First posted 9 May, acked 14th May.

      Andrew
