From: luca@coelho.fi (Luca Coelho)
Date: Mon, 19 Dec 2016 11:09:28 +0200
Subject: [PATCH 5/8] linux: drop __bitwise__ everywhere
In-Reply-To: <1481778865-27667-6-git-send-email-mst@redhat.com>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-6-git-send-email-mst@redhat.com>
Message-ID: <1482138568.26174.8.camel@coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-12-15 at 07:15 +0200, Michael S. Tsirkin wrote:
> __bitwise__ used to mean "yes, please enable sparse checks
> unconditionally", but now that we dropped __CHECK_ENDIAN__
> __bitwise is exactly the same.
> There aren't many users, replace it by __bitwise everywhere.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/arm/plat-samsung/include/plat/gpio-cfg.h    | 2 +-
>  drivers/md/dm-cache-block-types.h                | 6 +++---
>  drivers/net/ethernet/sun/sunhme.h                | 2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-fw-file.h | 4 ++--

For drivers/net/wireless/intel/iwlwifi/iwl-fw-file.h:

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Luca.
