From: balbi@ti.com (Felipe Balbi)
Date: Thu, 21 Jul 2011 12:39:33 +0300
Subject: [PATCH 3/4] dt: omap3: add generic board file for dt support
In-Reply-To: <4E27F264.4040409@ti.com>
References: <1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
	<CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
	<20110718090710.GZ5783@atomide.com>
	<20110719213458.GO6848@ponder.secretlab.ca>
	<4E27E967.7090501@ti.com>
	<20110721090918.GI23253@legolas.emea.dhcp.ti.com>
	<4E27F264.4040409@ti.com>
Message-ID: <20110721093932.GN23253@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 21, 2011 at 03:03:24PM +0530, Rajendra Nayak wrote:
> >IMHO, all omap_hwmod_*_data.c files become pretty much useless if we
> >move completely to DT. All hwmod data is passing today, can be passed
> >via DT and in a similar Hierarchical manner.
> 
> Would the data representation be equally readable?
> That's one of the problems I faced when I started
> looking at it initially trying to move a lot of these
> structures.

not to my eyes, heh. I'm too used to C, though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110721/91fe2145/attachment.sig>
