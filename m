From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 14:22:12 +0100
Subject: [PATCH 2/2] drm/sun4i: hdmi: Fix double flag assignation
In-Reply-To: <41337136-daa0-6773-e5e4-9bea60a14a49@micronovasrl.com>
References: <20181021163446.29135-1-maxime.ripard@bootlin.com>
 <20181021163446.29135-2-maxime.ripard@bootlin.com>
 <41337136-daa0-6773-e5e4-9bea60a14a49@micronovasrl.com>
Message-ID: <20181029132212.hxuk4bngy6ysk2ar@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 10:43:34AM +0200, Giulio Benetti wrote:
> Il 21/10/2018 18:34, Maxime Ripard ha scritto:
> > The is_double flag is a boolean currently assigned to the value of the d
> > variable, that is either 1 or 2. It means that this is_double variable is
> > always set to true, even though the initial intent was to have it set to
> > true when d is 2.
> > 
> > Fix this.
> > 
> > Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Reviewed-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied both, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/abda975c/attachment.sig>
