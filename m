From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 23 Jul 2012 14:53:54 +0400
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120722193243.GF5423@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
Message-ID: <500D2D42.3000006@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-07-2012 23:32, Andrew Lunn wrote:

>>> You can see the chain of dependencies here. So at minimum i would need
>>> to send the first three via Mark. I then need to cross my fingers and
>>> hope he really picks them up, because without them, we are going to
>>> have a number of boards which fail to find their root file system on
>>> an SPI flash.

>> Well, I'd like to think that generally I'm reasonably responsive to
>> patch submissions

> Well, this particular patch was first submitted May 19th and Ack-by
> Linus on May 14th.

    It was acked even before submitted? ;-)

> http://comments.gmane.org/gmane.linux.kernel.spi.devel/9937

> It was reposted 10 Jun and Acked-by again in Jun 10 by Linus.

> It was also reposted July 3.

WBR, Sergei
