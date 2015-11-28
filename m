From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Nov 2015 18:02:34 +0100
Subject: [PATCH 4/4] ARM: dt: mvebu: ix4-300d: Add ECC properties to NAND
 flash
In-Reply-To: <1448709248-21177-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1448709248-21177-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20151128170234.GJ32356@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 12:14:08PM +0100, Sebastian Hesselbarth wrote:
> The NAND device found on Lenovo ix4-300d uses 4-bit BCH ECC protection.
> Add the corresponding properties to the NAND node.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
