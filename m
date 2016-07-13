From: nicolas.dufresne@gmail.com (Nicolas Dufresne)
Date: Wed, 13 Jul 2016 09:46:28 -0400
Subject: [PATCH 2/2] [media] s5p-g2d: Replace old driver with DRM version
In-Reply-To: <20160712200202.7496445e@recife.lan>
References: <1464096493-13378-1-git-send-email-k.kozlowski@samsung.com>
 <1464096493-13378-2-git-send-email-k.kozlowski@samsung.com>
 <20160712200202.7496445e@recife.lan>
Message-ID: <1468417588.2867.6.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 12 juillet 2016 ? 20:02 -0300, Mauro Carvalho Chehab a ?crit?:
> I suspect that you'll be applying this one via DRM tree, so:
> 
> Em Tue, 24 May 2016 15:28:13 +0200
> Krzysztof Kozlowski <k.kozlowski@samsung.com> escreveu:
> 
> > Remove the old non-DRM driver because it is now entirely supported
> by
> > exynos_drm_g2d driver.
> >?
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Kamil Debski <k.debski@samsung.com>
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> 
> PS.: If you prefer to apply this one via my tree, I'm ok too. Just
> let me know when the first patch gets merged upstream.

Just a note that this is effectively an API break.

cheers,
Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160713/9e2fa231/attachment.sig>
