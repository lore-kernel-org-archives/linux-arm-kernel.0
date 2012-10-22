From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 21 Oct 2012 22:03:56 -0400
Subject: [PATCH V2] ARM: Kirkwood: new board USI Topkick
In-Reply-To: <20121021064053.GG21046@lunn.ch>
References: <1350679752-11931-1-git-send-email-jason@lakedaemon.net>
 <1350763764-737-1-git-send-email-jason@lakedaemon.net>
 <20121021064053.GG21046@lunn.ch>
Message-ID: <20121022020356.GG25828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 08:40:53AM +0200, Andrew Lunn wrote:
> On Sat, Oct 20, 2012 at 08:09:24PM +0000, Jason Cooper wrote:
> > +static struct mvsdio_platform_data topkick_mvsdio_data = {
> > +	/* unfortunately the CD signal has not been connected */
> > +};
> 
> Is this just cut/paste, or has it been verified that CD is not
> connected?

Both.  ;-)  There is no card slot on the topkick.  I'll have to go back
and test the dreamplug.

thx,

Jason.
