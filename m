From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 23 Feb 2014 12:33:19 -0500
Subject: [PATCH 4/4] ARM: mvebu: Add HP T5325 devices to
 {multi|mvebu}_v5_defconfig
In-Reply-To: <1393175982-18516-5-git-send-email-andrew@lunn.ch>
References: <1393175982-18516-1-git-send-email-andrew@lunn.ch>
 <1393175982-18516-5-git-send-email-andrew@lunn.ch>
Message-ID: <20140223173319.GQ7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 06:19:42PM +0100, Andrew Lunn wrote:
> The HP T5325 has a PCI based VGA controller. Add the frame buffer
> driver, and frame buffer support to the defconfig's. Additionally
> add the soc audio framework and the necessary codec.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/multi_v5_defconfig | 9 +++++++++
>  arch/arm/configs/mvebu_v5_defconfig | 9 +++++++++

This should be fine for this window.  In the future, though, we'll
follow the pattern for multi_v5 as for multi_v7.  Meaning those patches
go straight to the arm-soc maintainers since that file tends to get
riddled with conflicts.

thx,

Jason.
