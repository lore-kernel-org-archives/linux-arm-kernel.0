From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Dec 2009 10:58:21 +0000
Subject: [PATCH v2] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <1260194893-30149-1-git-send-email-ospite@studenti.unina.it>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<1260194893-30149-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20091215105820.GA14026@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 03:08:13PM +0100, Antonio Ospite wrote:
> This driver provides an interface for controlling LEDs (or vibrators)
> connected to PMICs for which there is a regulator framework driver.
> 
> This driver can be used, for instance, to control vibrator on all Motorola EZX
> phones using the pcap-regulator driver services.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Looks OK to me.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
