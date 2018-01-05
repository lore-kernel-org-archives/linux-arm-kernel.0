From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Jan 2018 10:39:47 +0100
Subject: [PATCH v5 00/12] drm/sun4i: Add A83t LVDS support
In-Reply-To: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20180105093947.kldzo2bdukt4volx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 12:02:26PM +0100, Maxime Ripard wrote:
> Hi,
> 
> Here is an attempt at supporting the LVDS output in our DRM driver. This
> has been tested on the A83T (with DE2), but since everything is basically
> in the TCON, it should also be usable on the older SoCs with minor
> modifications.
> 
> This was the occasion to refactor a bunch of things. The most notable ones
> would be the documentation, and split of the UI layers in the mixer code,
> and the switch to kfifo for our endpoint parsing code in the driver that
> fixes an issue introduced by the switch to BFS.
> 
> Let me know what you think,
> Maxime

I've applied all the patches.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180105/674f9db2/attachment-0001.sig>
