From: inbox@menno.io (Menno Finlay-Smits)
Date: Mon, 12 Mar 2018 00:02:17 +1300
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <20180309142724.GD27783@lunn.ch>
References: <20180304204115.GD21710@lunn.ch>
 <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180305142846.GJ25189@lunn.ch> <1520265474.2408.8.camel@debian.org>
 <1520297697.4117371.1292731088.7BEDFAAE@webmail.messagingengine.com>
 <1520395120.2285859.1294250416.5E5FC747@webmail.messagingengine.com>
 <20180307133611.GC18030@lunn.ch>
 <1520455769.3085111.1295233032.3B89F103@webmail.messagingengine.com>
 <20180307222722.GH1326@lunn.ch>
 <1520589187.923608.1297117744.23E3098C@webmail.messagingengine.com>
 <20180309142724.GD27783@lunn.ch>
Message-ID: <1520766137.2953662.1298951624.71C28713@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Could you also try linux-image-4.14.0-3-marvell from sid?
> > 
> > Can do. Should I just use the kernel packages from sid or update the whole system to sid?
> 
> Hi Menno
> 
> The kernel packages should be sufficient.

Bingo. The problem doesn't seem to happen using linux-image-4.14.0-3-marvell_4.14.17-1 from sid. I've now successfully transferred 1.5TB from an external USB drive onto the internal hard disk. Previously the problem would show up within the first few 100MB of the transfer.

Do you want me to help figure out which change to the kernel fixed the problem?

- Menno
