From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 2 Jul 2014 18:56:28 +0200
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140702183841.7c964832@armhf>
References: <20140702183841.7c964832@armhf>
Message-ID: <20140702165628.GO20799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 06:38:41PM +0200, Jean-Francois Moine wrote:
> This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.
> 
> The CODEC handles both I2S and S/PDIF inputs and does dynamic input
> switch in the TDA998x I2C driver on start/stop audio streaming.

Hi Jean-Francois

How well will this work with Russell concept of a front end and two
backends? Can you uses your CODEC twice, once with the I2S backend and
a second time with the S/PDIF backend?

	Andrew
