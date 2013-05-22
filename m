From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 22 May 2013 20:31:05 +0200
Subject: [PATCH 9/9] arm: mvebu: switch internal register address at
 runtime if needed
In-Reply-To: <20130522195942.33ff1131@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522174258.GO2824@lunn.ch> <20130522195942.33ff1131@skate>
Message-ID: <20130522183105.GQ26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +		/*
> > > +		 * Change the physical base address of the
> > > +		 * registers. From now on, and until
> > > +		 * debug_ll_io_init() is called below, it is not
> > > +		 * possible to do any print, because earlyprintk will
> > > +		 * not work.
> > 
> > Is its "not work" or "locks up the CPU as dead as a Dodo?".
> 
> locks up the CPU as a Dodo

Then i would suggest something a bit strong than "will not work".

     Andrew
