From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jun 2017 15:35:46 +0200
Subject: [PATCH 2/2] drm/sun4i: add const to drm_encoder_helper_funcs
 structures
In-Reply-To: <1497964080-27301-3-git-send-email-bhumirks@gmail.com>
References: <1497964080-27301-1-git-send-email-bhumirks@gmail.com>
 <1497964080-27301-3-git-send-email-bhumirks@gmail.com>
Message-ID: <20170620133546.f4ea4fhen2jnhsk5@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 06:38:00PM +0530, Bhumika Goyal wrote:
> Add const to drm_encoder_helper_funcs structures as they are only passed
> as an argument to the function drm_encoder_helper_add and this argument
> is of type const. So, add const to these structures.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/6b4310e9/attachment.sig>
