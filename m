From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 19:19:33 +0100
Subject: [PATCH v3 5/5] ARM: kirkwood: Add HP T5325 devices to
 {multi|mvebu}_v5_defconfig
In-Reply-To: <1393349643-6652-6-git-send-email-andrew@lunn.ch>
References: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
 <1393349643-6652-6-git-send-email-andrew@lunn.ch>
Message-ID: <6144493.7kns7zvPT9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014 18:34:03 Andrew Lunn wrote:
> The HP T5325 has a PCI based VGA controller. Add the frame buffer
> driver, and frame buffer support to the defconfig's. Additionally
> add the soc audio framework and the necessary codec.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
Does the VGA console still work with the new PCI driver?

I noticed we're not setting 'vga_base'.

	Arnd
