From: davem@davemloft.net (David Miller)
Date: Tue, 08 Jan 2013 17:58:50 -0800 (PST)
Subject: [PATCH 1/1 net-next] net: fec: enable pause frame to improve
 rx prefomance for 1G network
In-Reply-To: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
References: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130108.175850.1601684784999646243.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


As others have mentioned, this is definitely something which must be
automatically detected via PHY autonegotiation results or the user
forcing the setting via ethtool.  Not like this.
