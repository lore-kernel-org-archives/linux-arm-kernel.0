From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 16 Feb 2014 22:06:02 -0500
Subject: [PATCH 0/2] Kirkwood RD88F6192 and RD88F6281 DT conversion
In-Reply-To: <1392469193-25883-1-git-send-email-andrew@lunn.ch>
References: <1392469193-25883-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140217030602.GK7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 01:59:51PM +0100, Andrew Lunn wrote:
> These two patches convert two Marvell Reference designs from old style
> setup files to DT. No testing has been performed other than that they
> compile.
> 
> Andrew Lunn (2):
>   ARM: Kirkwood: Add DT description of rd88f6192.
>   ARM: Kirkwood: convert rd88f6281-setup.c to DT.
> 
>  arch/arm/boot/dts/Makefile                  |   3 +
>  arch/arm/boot/dts/kirkwood-rd88f6192.dts    | 112 ++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts |  26 +++++
>  arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts |  31 ++++++
>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi   | 152 ++++++++++++++++++++++++++++
>  5 files changed, 324 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6192.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi

Series applied to mvebu/dt

thx,

Jason.
