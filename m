From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:46:04 +0200
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
In-Reply-To: <8332148.Z1shujgC24@wuerfel>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <8332148.Z1shujgC24@wuerfel>
Message-ID: <20140515144604.GA10407@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We had a couple of conflicts in 3.15 between kirkwood and dove both
> getting moved to multiplatform. Any idea how this can be done better
> this time?
> 
> There are three other series that may or may not make it into 3.16
> and that will have conflicts with this one:
> 
> - remove mv78xx0
> - remove mach-dove
> - convert orion5x to multiplatform
> 
> If we can decide which ones we should have, we can make sure the
> patches correctly build on top of one another or get merged into
> one per subsystem.

I've not tried, but i doubt there will be conflicts between orion5x
and kirkwood.

For the three removal patchsets, i guess the simple option is to
pre-merge them and send it all as one big patchset.

	  Andrew
