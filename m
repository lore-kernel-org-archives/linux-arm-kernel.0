From: davem@davemloft.net (David Miller)
Date: Mon, 19 Nov 2012 14:16:53 -0500 (EST)
Subject: [GIT PULL] Marvell mvneta Ethernet/MDIO drivers checkpatch fixes
In-Reply-To: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121119.141653.1660827388689535803.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Mon, 19 Nov 2012 12:00:31 +0100

> Sebastian Hesselbarth noticed that the new mvmdio and mvneta drivers
> produce a number of checkpatch warnings, related to the incluse of
> <asm/delay.h> and to the style of multiline comments. The following
> three patches fix those checkpatch warnings. Feel free to integrate
> them either as follow-up patches of the network driver patches, or to
> squash them into the driver patches as you prefer.
> 
> David, are you OK with those patches and the fact that we carry them
> through the arm-soc tree, as we agreed to do for the mvmdio and mvneta
> drivers? Those patches are really simple/stupid fixes.

No problem, thanks.
