From: Steve.Glendinning@smsc.com (Steve.Glendinning at smsc.com)
Date: Mon, 8 Feb 2010 12:27:50 +0000
Subject: smsc911x suspend/resume
In-Reply-To: <20100208115316.GA28972@buzzloop.caiaq.de>
Message-ID: <OFF34C9E86.0CCFA0E8-ON802576C4.0041FE48-802576C4.00447BBD@smsc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I don't have the code in front of me (I'm travelling today) but IIRC
> > the driver doesn't place the LAN9220 in a specific power saving state,
> > so as far as the LAN9220 is concerned it's not actually suspended.
> 
> It does, I added that awhile back in b6907b0c7. But as I say, this is
> currently hard-coded to D1, and if support for D2 is desired, we would
> need to make that a platform data option.

You're right, and I should remember as I reviewed it!

Steve
