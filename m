From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 10:41:47 +0100
Subject: [PATCH] drm/sun4i: Fix dclk_set_phase
In-Reply-To: <1519836413-35023-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1519836413-35023-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180301094147.2mjgpfq4q64gtptv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 05:46:53PM +0100, Giulio Benetti wrote:
> Phase value is not shifted before writing.
> 
> Shift left of 28 bits to fit right bits
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/a0834cff/attachment.sig>
