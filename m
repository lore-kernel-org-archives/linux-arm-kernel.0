From: davem@davemloft.net (David Miller)
Date: Mon, 29 Apr 2013 15:15:28 -0400 (EDT)
Subject: [PATCHv2 0/3] Add support for velocity network driver on
 platform devices
In-Reply-To: <1367221841-14563-1-git-send-email-linux@prisktech.co.nz>
References: <1367221841-14563-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130429.151528.2251094691456287740.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


You prepared these patches against a net-next tree which is at least
a week old, I know this because that's when the NETIF_F_* flags for
VLAN offloading changed their names which causes your third patch
to fail to apply.

Do not do this, net-next changes every day and rapidly, don't take
the chance that the driver you're touching is unpopular and thus
hasn't had changes to it recently.  Tree-wide interface changes
happen all the time.
