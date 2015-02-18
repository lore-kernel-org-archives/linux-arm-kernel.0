From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Feb 2015 16:20:03 -0500
Subject: [PATCH 0/2] ARM: shmobile: emev2 dts: Add pinmux support
In-Reply-To: <1424179915-17417-1-git-send-email-geert+renesas@glider.be>
References: <1424179915-17417-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150218212002.GB12754@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 02:31:53PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> Here are the two remaining patches from Niklas S?derlund to add
> pinmux support for EMMA Mobile EV2. The patches for the actual pinctrl
> driver have already landed in Linus' tree.
> 
> Thanks for applying!

Thanks, done.

> Niklas S?derlund (2):
>   ARM: shmobile: emev2 dtsi: Add PFC information
>   ARM: shmobile: emev2-kzm9d dts: Add PFC information for uart1
> 
>  arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
>  arch/arm/boot/dts/emev2.dtsi      | 10 ++++++++++
>  2 files changed, 23 insertions(+)
