From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Mar 2018 10:46:04 +0100
Subject: [PATCH 8/8] media: sun6i: Add g_parm/s_parm ioctl support
In-Reply-To: <20180305093535.11801-9-maxime.ripard@bootlin.com>
References: <1519697113-32202-1-git-send-email-yong.deng@magewell.com>
 <20180305093535.11801-1-maxime.ripard@bootlin.com>
 <20180305093535.11801-9-maxime.ripard@bootlin.com>
Message-ID: <20180305094604.ggbj6qhw73mkwn75@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 10:35:35AM +0100, Maxime Ripard wrote:
> Add a g_parm and s_parm callback in order to be able to control the sensor
> framerate of the sensor.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Hmmm, that patch shouldn't have been there. This is an outdated
version based on Hans g_parm/s_parm rework that will not need this
anymore.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/e5be953a/attachment.sig>
