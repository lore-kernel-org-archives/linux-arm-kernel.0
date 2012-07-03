From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jul 2012 17:32:40 +0200
Subject: [PATCH v2 11/12] ARM: Kirkwood: Use DT to configure SATA device.
In-Reply-To: <CAMW5Ufa2bsYs9VD2g9hJWKpcQNcZt+WXCA1ohYoHeLk9SambSg@mail.gmail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-12-git-send-email-andrew@lunn.ch>
 <CAMW5Ufa2bsYs9VD2g9hJWKpcQNcZt+WXCA1ohYoHeLk9SambSg@mail.gmail.com>
Message-ID: <20120703153240.GH17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 10:52:17AM -0400, Josh Coombs wrote:
> On Tue, Jul 3, 2012 at 10:22 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> > Convert boards using DT, but the old way of configuring SATA to now
> > use properties in there DT file.
> 
> Andrew, should I be updating my GoFlex patch set to work with these
> new Kirkwood DT abstractions, and if so is there a specific tree you'd
> prefer I work against, or should I wait to see if my existing patch
> set is approved as is and update with a new patch once these updates
> land in an RC?

Hi Josh

I would suggest waiting for a day or two. The IRQ and GPIO patch may
cause comments and require more work. Unfortunately, without that
patch, the rest are pretty useless, since they use IRQs in DT.

If there are no show stoppers, Jason has a for-next tree which these
patches should get pulled into, and others can use as a basis.

	Andrew
