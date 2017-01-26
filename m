From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Jan 2017 10:54:56 +0100
Subject: [PATCH v2 6/9] drm/panel: Add Netron DY E231732
In-Reply-To: <20160906144620.6322-7-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-7-maxime.ripard@free-electrons.com>
Message-ID: <20170126095456.GE3613@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 04:46:17PM +0200, Maxime Ripard wrote:
> The E231732 is a 7" panel with a resolution of 800x480.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

This is missing a device tree binding, but since this is a simple one I
added it. The commit message also says the resolution is 800x480, which
conflicts with what's in the display mode definition, so I've also
fixed that up while at it.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/f0e87c0b/attachment.sig>
