From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 16 May 2014 16:11:46 +0200
Subject: [PATCH v2 0/3] Update the Keymile kirkwood DTS files
In-Reply-To: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
References: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20140516141146.GH10407@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:49:00AM +0200, Valentin Longchamp wrote:
> This series resynchs the Keymile Kirkwood DTS files with mainline since
> the boards do not boot anymore with the 3.15 rc kernels (to be honest, I
> have not tested the last 2-3 releases).
> 
> The changes are the addition of the PCIe controller for the 98dx4122
> SoC, the explicit disabling of the SATA phys for this same SoC and
> finally the enabling of the PCIe controller on the Keymile Reference
> design.
> 
> The series introduces kirkwood-km_common.dtsi that factors the common
> nodes between kirkwood-km_kirkwood.dts and the new board/design below.
> 
> The series also adds a new DTS for another Keymile generic design where
> the mv64xxx eth interace is configured with fixed parameters to no phy
> but a switch (for board internal communication).

Hi Valentin

Looks good to me.

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew
