From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 14 Mar 2018 10:30:50 +0100
Subject: [PATCH v2] drm/sun4i: move rgb mode_valid from connector to
 encoder
In-Reply-To: <1520941017-81177-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1520941017-81177-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180314093050.aimmdpx4heghuf74@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 12:36:57PM +0100, Giulio Benetti wrote:
> mode_valid function must be connected to encoder.
> Otherwise it could get not be called by drm in the case there's a
> bridge connected to encoder instead of a panel.
> 
> Move mode_valid function pointer to encoder helper functions,
> changing its prototype according to encoder helper function pointer.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180314/0c7ec9a0/attachment.sig>
