From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Nov 2017 19:19:54 +0800
Subject: [PATCH] ARM: dts: vf610-zii-dev-c: Fix switch EEPROM size
In-Reply-To: <1510271336-30769-1-git-send-email-andrew@lunn.ch>
References: <1510271336-30769-1-git-send-email-andrew@lunn.ch>
Message-ID: <20171116111953.GP25384@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 12:48:56AM +0100, Andrew Lunn wrote:
> The two Ethernet switches have an AT24C512 each. This is a 64K device,
> not 512 bytes as currently listed in the device tree.
> 
> Reported-by: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied, thanks.
