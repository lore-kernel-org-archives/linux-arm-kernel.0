From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Mar 2017 14:05:16 +0100
Subject: [PATCH v2 0/3] Add EHCI support for Armada 37xx
In-Reply-To: <20170309110424.2187-1-gregory.clement@free-electrons.com>
References: <20170309110424.2187-1-gregory.clement@free-electrons.com>
Message-ID: <20170309130516.GB21487@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 12:04:21PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> The EHCI controller in the Armada 37xx SoCs is the one used on many
> other mvebu SoCs such as the orion5x, the kirkwood, or the
> armada. However, for Armada 37xx an extra initialization step is
> needed: this is the purpose of the first patch.
> 
> The second patch allows to build the driver for the ARM64 Armada SoCs.
> 
> The last one enables the EHCI in the device tree.
> 
> This second version takes into account the review from Andrew Lunn and
> Thomas Petazzoni.

Hi Gregory

Thanks for making the changes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
