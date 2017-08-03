From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 Aug 2017 19:48:22 +0200
Subject: [patch v1 0/2] JTAG driver introduction
In-Reply-To: <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <20170802141209.GB25781@lunn.ch>
 <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
Message-ID: <20170803174822.GI15018@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Andrew
> 
> Thanks a lot for review.
> 

> We used user space tool for that, which is an adaptation of some
> Lattice tools, which allows programming of SVF files. We are using
> it for Lattice CPLD burning, since we have for such devices on our
> system, but this tool could be used for programming other devices
> from other vendors as well.
 
> https://github.com/mellanoxbmc/mellanox-bmc-tools

Since you are defining a new Kernel ABI here, it would be good to get
some buy-in from potential users for the ABI. Maybe for the next
version of the patchset you can cross post to the OpenOCD-devel list?

	Andrew
