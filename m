From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Jan 2017 20:57:12 +0100
Subject: [PATCH v5 0/2] Add support for the ethernet switch on the
 ESPRESSObin
In-Reply-To: <87r33s2ynp.fsf@free-electrons.com>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170120.141705.1390880809796992457.davem@davemloft.net>
 <87r33s2ynp.fsf@free-electrons.com>
Message-ID: <20170124195712.GS10895@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 05:47:06PM +0100, Gregory CLEMENT wrote:
> Hi David,
>  
>  On ven., janv. 20 2017, David Miller <davem@davemloft.net> wrote:
> 
> > From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Date: Thu, 19 Jan 2017 22:49:32 +0100
> >
> >> I created a new family for this switch and filled the ops structure
> >> by selecting which seems the more appropriate functions. I rebased
> >> the series on net-next/master which allowed me to benefit to the
> >> eeprom functions introduced for the 6390.
> >
> > It looks like there will be at least one more respin of this series,
> > specifically to remove the new family as Vivien seems to object to
> > this.
> 
> I am about to send a new version. However about removing the new family,
> I thought that with the confirmation from Andrew we could keep it.

Hi Gregory

Yes, keep it. It will hopefully be short lived, but it is needed at
the moment.

    Andrew
