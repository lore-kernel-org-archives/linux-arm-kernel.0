From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Nov 2015 22:11:29 +0100
Subject: [PATCH 1/4] ARM: dt: mvebu: ix4-300d: remove whole flash partition
In-Reply-To: <1448709248-21177-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1448709248-21177-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20151128211129.GK32356@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>On Sat, Nov 28, 2015 at 12:14:05PM +0100, Sebastian Hesselbarth wrote:
> Current NAND node has an additional flash partition for the whole
> flash overlapping with real partitions. Remove this partition as
> the whole flash is already represented by the NAND device itself.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Given Benoit comment

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
