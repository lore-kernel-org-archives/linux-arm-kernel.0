From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 08:13:22 -0500
Subject: [PATCH 0/3] Convert more of NSA310 to DT.
In-Reply-To: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
References: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130123131322.GJ1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 03:08:47PM +0100, Andrew Lunn wrote:
> This patchset converts more of the NSA310 into device tree.
> 
> Currently untested.
> 
> Andrew Lunn (3):
>   ARM: Kirkwood: Convert NSA310 to DT based regulators.
>   ARM: Kirkwood: Convert NSA310 to use gpio-poweroff driver
>   ARM: Kirkwood: Convert NSA310 I2C to device tree
> 
>  arch/arm/boot/dts/kirkwood-nsa310.dts |   27 +++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-nsa310.c |   43 ---------------------------------
>  2 files changed, 27 insertions(+), 43 deletions(-)

Whole series applied to mvebu/dt

thx,

Jason.
