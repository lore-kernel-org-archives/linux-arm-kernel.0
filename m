From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Sep 2013 13:00:43 +0200
Subject: [PATCH v2 00/12] CPU idle for Armada XP
In-Reply-To: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130913110043.GJ19363@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, Sep 13, 2013 at 12:06:29PM +0200, Gregory CLEMENT wrote:
> Hello,
> 
> This patch set adds the CPU idle support for Armada XP and prepares
> the support for Armada 370. This was based on the work of Nadav
> Haklai.

Hi Gregory.

Kirkwood has the ability to put the DDR into self refresh mode, which
is used as part of the second level idle mode. Does 370/XP have this?

For XP, with it being SMP, it would be a bit more complex, since you
would not want to use it unless all CPUs were idle.

      Thanks
	Andrew
