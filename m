From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 22:39:13 +0100
Subject: [PATCH 2/5] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <8344066.GP0Bf5lvlE@wuerfel>
References: <cover.1397552154.git.anders.berg@lsi.com>
 <02c006a6fc64131df82981abbc1c71c7af52254e.1397552154.git.anders.berg@lsi.com>
 <8344066.GP0Bf5lvlE@wuerfel>
Message-ID: <20140422213913.GB24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:45:48PM +0200, Arnd Bergmann wrote:
> "uartclk" is not a valid string for pl011, as per binding:
> 
> | - clocks:  When present, must refer to exactly one clock named
> |           "apb_pclk"

The binding document is basically *wrong*.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
