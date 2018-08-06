From: eric@anholt.net (Eric Anholt)
Date: Mon, 06 Aug 2018 12:58:20 -0700
Subject: [PATCH v3 09/10] drm/vc4: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180804161530.12275-10-alexandru-cosmin.gheorghe@arm.com>
References: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
 <20180804161530.12275-10-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <87va8n1d43.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com> writes:

> A new helper function(__drm_atomic_helper_plane_reset) has been added
> for linking a plane with its state and resetting the core
> properties(alpha, rotation, etc.) to their default values.
> Use that instead of duplicating the logic.
>
> __drm_atomic_helper_plane_reset initializes the alpha property to its
> max value, which is defined by the drm core as DRM_BLEND_ALPHA_OPAQUE,
> so nothing changes regarding the alpha value.
>
> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180806/0a171009/attachment.sig>
