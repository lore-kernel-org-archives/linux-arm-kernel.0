From: davem@davemloft.net (David Miller)
Date: Wed, 11 Jan 2017 10:03:23 -0500 (EST)
Subject: [PATCH] net: phy: marvell: fix Marvell 88E1512 used in SGMII mode
In-Reply-To: <61950d83-cbe1-6e1b-4afc-bc471b386ff3@gmail.com>
References: <E1cR5bt-0000O8-1T@rmk-PC.armlinux.org.uk>
 <61950d83-cbe1-6e1b-4afc-bc471b386ff3@gmail.com>
Message-ID: <20170111.100323.1789649822390190475.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 10 Jan 2017 15:24:11 -0800

> Fixes: 6cfb3bcc0641 ("Marvell phy: check link status in case of fiber
> link.")

Thanks, I added this to Russell's commit message.
