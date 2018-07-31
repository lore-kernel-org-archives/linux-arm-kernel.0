From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 14:30:41 +0200
Subject: [PATCH v3 00/19] arm64: dts: allwinner: A64 boards DT updates
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180731123041.33gl4zcaxlvli3to@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 01:31:18PM +0100, Andre Przywara wrote:
> Hi,
> 
> only smaller changes compared to v2, addressing the comments on the
> ML. This fixes Ethernet for the Nano Pi A64 and removes the DT nodes
> for the non-existent BT part of this board. Also some fixes for the
> OrangePi as requested by Maxime.
> 
> Please note:
> I am leaving for a three weeks holiday in a few hours, so won't be
> able to respond or work on this.
> Maxime, if you feel like you want to merge some parts, feel free to pick
> some patches and/or make adjustments. Otherwise I will be picking this
> up once I am back end of August.

Apart from the serdev patch,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
