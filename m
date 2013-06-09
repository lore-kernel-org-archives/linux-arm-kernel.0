From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 09 Jun 2013 23:36:24 +0200
Subject: [PATCH 4/6] ARM: sunxi: dt: Add Allwinner A10s DTSI
In-Reply-To: <1370795767-9769-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370795767-9769-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <3346364.JR9UrJYqP8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 June 2013 18:36:05 Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 286 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 286 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun5i-a10s.dtsi

Would it make sense to split out the parts that are common with A13 into
a separate sun5i.dtsi file?

	Arnd
