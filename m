From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Jul 2013 20:45:20 +0200
Subject: [PATCH 4/4] ARM: dove: add initial DT file for Globalscale D2Plug
In-Reply-To: <1375100946-28521-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1375100946-28521-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130729184520.GI24782@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 02:29:06PM +0200, Sebastian Hesselbarth wrote:
> This adds an initial DT file for the Globalscale D2Plug with Dove SoC.
> Currently, one LED is missing and I have not been able to get SD8787 driver
> working. Those will be taken care of later.

Hi Sebastion

I took a hard look at SDIO and failed to get it working when doing
DMA. Polled IO does however work. I guess we need some help from
Marvell engineers before we get stable SDIO with DMA.

	Andrew
