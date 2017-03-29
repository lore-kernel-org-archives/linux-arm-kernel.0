From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Mar 2017 09:09:53 +0200
Subject: [PATCH 1/2] drm/sun4i: Add display backend interrupt to device
 tree binding
In-Reply-To: <20170327143847.16259-2-wens@csie.org>
References: <20170327143847.16259-1-wens@csie.org>
 <20170327143847.16259-2-wens@csie.org>
Message-ID: <20170329070953.x64daho2kfgr4fbc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 10:38:46PM +0800, Chen-Yu Tsai wrote:
> The display backend has an interrupt line. Add it to the device tree
> binding.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

The patches prefix for the binding documentation is usually
dt-bindings:

I've changed that and applied that patch, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170329/2a3e4e0d/attachment.sig>
