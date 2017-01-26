From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Jan 2017 11:51:08 +0100
Subject: [PATCH v2 6/9] drm/panel: Add Netron DY E231732
In-Reply-To: <20170126095456.GE3613@ulmo.ba.sec>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-7-maxime.ripard@free-electrons.com>
 <20170126095456.GE3613@ulmo.ba.sec>
Message-ID: <20170126105108.sdj6tieo6bnht2zg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 10:54:56AM +0100, Thierry Reding wrote:
> On Tue, Sep 06, 2016 at 04:46:17PM +0200, Maxime Ripard wrote:
> > The E231732 is a 7" panel with a resolution of 800x480.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> 
> This is missing a device tree binding, but since this is a simple one I
> added it. The commit message also says the resolution is 800x480, which
> conflicts with what's in the display mode definition, so I've also
> fixed that up while at it.

Sorry for that :/

Thanks a lot,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/2081a192/attachment.sig>
