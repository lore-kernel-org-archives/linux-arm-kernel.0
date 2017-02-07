From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 7 Feb 2017 15:44:59 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.11 (#3)
In-Reply-To: <3013051.dlCd81dF2f@wuerfel>
References: <87vasvz575.fsf@free-electrons.com>
 <3013051.dlCd81dF2f@wuerfel>
Message-ID: <20170207144459.GH17018@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Pulled into next/dt, nice to see this getting added! Just for my information,
> do we also support the actual switch driver in Linux, or just the parts that
> are common with Armada?

Hi Arnd

This just supports the SoC part of the switch. As Gregory pointed out,
this switch is a completely different beast to the Marvell SOHO
switches DSA supports.

	 Andrew
