From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jul 2015 04:10:10 -0700
Subject: [PATCH] pinctrl: dra: dt-bindings: Add virtual mode
 configuration option
In-Reply-To: <1434986546-2211-1-git-send-email-nm@ti.com>
References: <1434986546-2211-1-git-send-email-nm@ti.com>
Message-ID: <20150714111009.GS17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150622 08:24]:
> In addition to the regular mux configuration such as mux mode 1,
> 2 etc, certain pins of DRA7 require to have "virtual mode" also
> programmed. This allows for predefined delay characteristics to
> be used by the SoC to meet timing characterstics needed for the
> interface.
> 
> Provide easy to use macro to do the same.
> 
> It is important to note that the official TI guidelines recommend
> to do as minimal pin reconfiguration beyond the bootloader given
> the design of the hardware involved which can result in substantial
> glitches which may impair functionality of certain peripherals.

Applying into omap-for-v4.3/dt thanks.

Tony
