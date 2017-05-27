From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 27 May 2017 16:10:38 +0800
Subject: [PATCH 2/2] ARM: VF610: ZII devel b: Add switch eeprom-length
 properties
In-Reply-To: <1495755884-31341-3-git-send-email-andrew@lunn.ch>
References: <1495755884-31341-1-git-send-email-andrew@lunn.ch>
 <1495755884-31341-3-git-send-email-andrew@lunn.ch>
Message-ID: <20170527081036.GA4528@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 01:44:44AM +0200, Andrew Lunn wrote:
> Two of the Ethernet switches on this board have EEPROMs connected.
> Add the eeprom-length property to the device tree, making it possible
> to access the EEPROM using ethtool -e.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied with a bit update on subject prefix.  Thanks.

Shawn
