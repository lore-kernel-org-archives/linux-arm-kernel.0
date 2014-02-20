From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 20 Feb 2014 14:22:29 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <11515265.X2qOAjvHY6@wuerfel>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1392896076.23342.37.camel@kazak.uk.xensource.com>
 <20140220121821.GO11878@lunn.ch> <11515265.X2qOAjvHY6@wuerfel>
Message-ID: <1392906149.30563.12.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 14:04 +0100, Arnd Bergmann wrote:
> On Thursday 20 February 2014 13:18:21 Andrew Lunn wrote:
> > > IOW that all of the platforms currently supported by the
> > > Debian kirkwood flavour remain supportable in the same binary after this
> > > change. It looks like it should be to me, but I'm not 100% sure.
> > 
> > If you don't support LaCie 2Big and 5Big, HP t5325 thin client and
> > Marvell OpenRD then yes, you have one binary. That binary could
> > potentially support over v5 machines, but i have no idea what ARM
> > machines Debian actually supports. Is there a list somewhere?
> 
> http://anonscm.debian.org/viewvc/kernel/releases/linux/3.12.9-1/debian/config/armel/config.kirkwood?view=markup
> 
> just lists all kirkwood machines as enabled, but that of course
> doesn't meant they are actually working or supported.

In general boards get added there by someone who is running Debian on
that platform. We don't really have any way to tell what platforms
people are actually using.

Ian.
