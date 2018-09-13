From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 13 Sep 2018 12:00:57 +0200
Subject: [PATCH v3 1/5] drm/rockchip: prepare common code for cdns and
 rk dpi/dp driver
In-Reply-To: <1535451894-2518-2-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
 <CGME20180828102612epcas2p376fa6f21ce57f4753a8d0f80f5359842@epcas2p3.samsung.com>
 <1535451894-2518-2-git-send-email-dkos@cadence.com>
Message-ID: <20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92~T7VgDpN8L3204732047eucas1p2_@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Damian,

Quite late but.

On 28.08.2018 12:24, Damian Kos wrote:
> - Extracted common fields from cdn_dp_device to a new cdns_mhdp_device
>   structure which will be used by two separate drivers later on.
> - Moved some datatypes (audio_format, audio_info, vic_pxl_encoding_format,
>   video_info) from cdn-dp-core.c to cdn-dp-reg.h.
> - Changed prefixes from cdn_dp to cdns_mhdp
>     cdn -> cdns to match the other Cadence's drivers
>     dp -> mhdp to distinguish it from a "just a DP" as the IP underneath
>       this registers map can be a HDMI (which is internally different,
>       but the interface for commands, events is pretty much the same).
> - Modified cdn-dp-core.c to use the new driver structure and new function
>   names.
>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Many changes, hard to review. Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej
