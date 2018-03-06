From: inbox@menno.io (Menno Finlay-Smits)
Date: Tue, 06 Mar 2018 13:54:57 +1300
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <1520265474.2408.8.camel@debian.org>
References: <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
 <20180304204115.GD21710@lunn.ch>
 <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180305142846.GJ25189@lunn.ch> <1520265474.2408.8.camel@debian.org>
Message-ID: <1520297697.4117371.1292731088.7BEDFAAE@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Mar 2018, at 04:57, Yves-Alexis Perez wrote:
> On Mon, 2018-03-05 at 15:28 +0100, Andrew Lunn wrote:
> > Would it be possible to try to reproduce this problem with 4.9.86 on
> > the hardware reporting the issue?
> 
> 4.9.82-1+deb9u3 is currently in the archive. Menno, could you give it a shot?

Will do. I need to get the NAS back to running Scratch as I went back to Jessie for comparison (similar looking problems there too) but I'll get it done as soon as I can.

Also, I can confirm that I was indeed copying from an external USB disk with just "rsync -av <source> <dest>".
