From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 15 Jun 2013 15:14:32 +0200
Subject: [PATCH 0/6] Add support for Allwinner A10s SoCs
In-Reply-To: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130615131432.GW16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Jun 09, 2013 at 06:36:01PM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> This patch serie reworks a bit the pinctrl driver and adds the necessary
> bits needed to support the Allwinner A10s SoC.
> 
> This SoC is a bit in between the A10 and A13. Notable differences with
> the A13 is the addition of an HDMI controller and of the EMAC.
> 
> For the time being (ie until we find a proper datasheet for this SoCs),
> the clock definition is taken from the A10 one.
> 
> This patches depends on the "Add external interrupt support for Allwinner SoCs"
> patch serie.

Do you have any comments on the two patches on the pinctrl driver?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
