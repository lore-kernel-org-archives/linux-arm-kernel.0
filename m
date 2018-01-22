From: eric@anholt.net (Eric Anholt)
Date: Tue, 23 Jan 2018 07:35:10 +1100
Subject: [PATCH v2 05/19] drm/vc4: Use the alpha format field in
 drm_format_info
In-Reply-To: <38d4d0a085634a0b8308e819c846b9173d4d93df.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
 <38d4d0a085634a0b8308e819c846b9173d4d93df.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <87vaft7htt.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Now that the drm_format_info has a alpha field to tell if a format embeds
> an alpha component in it, let's use it.
>
> Cc: Eric Anholt <eric@anholt.net>
> Reviewed-by: Daniel Vetter <daniel.vetter@intel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I had sent my r-b for the last version of this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180123/e660b02d/attachment.sig>
