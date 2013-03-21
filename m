From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Mar 2013 22:25:21 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321205545.GA8358@obsidianresearch.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
 <20130321205545.GA8358@obsidianresearch.com>
Message-ID: <20130321212521.GR21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Or, better, locate all the internal registers above 8G and use
> contiguous DRAM mapping from 0 -> 8GB

Wouldn't that get us into a 640KBs is enough for everyone situation?
Why not put the IO at the very top of the 1TB address range?

    Andrew
