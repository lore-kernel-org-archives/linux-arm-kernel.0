From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 14 Mar 2016 14:07:22 -0700
Subject: [PATCH 05/13] input: convert sun4i-ts to use
 devm_thermal_zone_of_sensor_register
In-Reply-To: <20160309214514.GA18066@dtor-ws>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-6-git-send-email-edubezval@gmail.com>
 <20160309214514.GA18066@dtor-ws>
Message-ID: <20160314210721.GB4740@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 01:45:14PM -0800, Dmitry Torokhov wrote:
> On Wed, Mar 09, 2016 at 01:35:27PM -0800, Eduardo Valentin wrote:
> > This changes the driver to use the devm_ version
> > of thermal_zone_of_sensor_register and cleans
> > up the  local points and unregister calls.
> > 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Lukasz Majewski <l.majewski@samsung.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Jens Thiele <karme@karme.de>
> > Cc: linux-input at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I guess it will make sense to merge through your tree unless you want to
> hold off until after I merge winth mainline (around -rc3) assuming that
> it even makes into 4.6.

No rush from my side. I would rather get the right review cycles.

The devm_ APIs were sent to 4.6-rc1 (well, right now in Rui's tree, but
I assume he is sending them).

Thanks for your review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/49ac3d45/attachment.sig>
