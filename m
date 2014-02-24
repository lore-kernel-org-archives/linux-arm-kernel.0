From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Feb 2014 20:12:21 +0100
Subject: [PATCH v2 3/5] ARM: mvebu: Add HP T5325 thin client
In-Reply-To: <20140224191014.GE1010@titan.lakedaemon.net>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
 <1393264898-28939-4-git-send-email-andrew@lunn.ch>
 <20140224191014.GE1010@titan.lakedaemon.net>
Message-ID: <20140224191221.GB29288@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 02:10:14PM -0500, Jason Cooper wrote:
> Subject should be "ARM: kirkwood: ..."

I disagree, but lets discuss that with the other patch.

> 
> On Mon, Feb 24, 2014 at 07:01:36PM +0100, Andrew Lunn wrote:
> > Convert the kirkwood t5325-setup.c to mostly device tree for
> > mach-mvebu. Part of the audio setup needs to remain in C for the
> > moment until suitable bindings are designed and implemented. So add
> > board code, triggered by the compatibility string.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > v2:
> > Remove spaces around KEY_POWER
> > Correct indentation of help text in Kconfig.
> > Put dts file into a patch of its own.
> > ---
> >  arch/arm/boot/dts/Makefile        |  1 +
> 
> This Makefile change should be in the same patch as the one adding the
> dts file.

Agreed. Will fix.

	Andrew
