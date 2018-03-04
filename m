From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Mar 2018 21:41:15 +0100
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
References: <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
Message-ID: <20180304204115.GD21710@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2018 at 06:41:57PM +0100, Martin Michlmayr wrote:
> A Debian user reported the following issue on QNAP TS-119P II with
> 4.9.65:
> 
> * Menno Finlay-Smits <inbox@menno.io> [2018-01-21 23:08]:
> > Rsyncing files between 2 HDDs on a QNAP 119p with a fresh, minimal install of
> > stretch NAS (armel) causes the kernel to fail after ~20mins with a kernel
> > memory overwrite attempt (full error below). 

Please can you give me the exact rsync command being used. Having a
unix domain socket seems a bit odd for rsync'ing files on the same
machine.

	Thanks
		Andrew
