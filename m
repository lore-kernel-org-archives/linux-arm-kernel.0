From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 May 2012 15:19:35 +0200
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C6C@IL-MB01.marvell.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C6C@IL-MB01.marvell.com>
Message-ID: <20120515131935.GI6820@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I would strongly advise on using "mrvl,mv78230" as the binding name. It isn't
> > as if you can't have multiple names associated with one binding.
> > 
> > Also, given how close they are, do we really need separate machine support
> > files?
> The problem with 78230 is that it's only one flavor of the AXP family which 
> includes 78230, 78260 and 78460 resulting different core count, L2 size, DRAM bandwidth, etc.

Can you explain the naming scheme and mapping to device numbers?
Please don't limit it to these new devices, but also include the
existing supported devices. From that we might be able to figure out
and appropriate naming scheme.

Thanks
	Andrew
