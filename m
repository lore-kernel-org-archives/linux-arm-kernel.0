From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Aug 2015 15:54:51 +0100
Subject: [PATCH] arm: tegra: update default configuration
In-Reply-To: <1440670255-19437-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440670255-19437-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20150827145451.GB5313@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 12:10:55PM +0200, Marcel Ziswiler wrote:

>   * WM9712 audio/touch controller as found on Colibri T20

> +CONFIG_BATTERY_WM97XX=y

Does the system really have the wm9712 wired up as a battery monitor?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150827/8445fd4d/attachment.sig>
