From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 12 Jul 2017 17:41:20 +0800
Subject: [PATCH 09/16] drm/rockchip: Use for_each_oldnew_plane_in_state in
 vop_crtc_atomic_flush
In-Reply-To: <20170712081344.25495-10-maarten.lankhorst@linux.intel.com>
References: <20170712081344.25495-1-maarten.lankhorst@linux.intel.com>
 <20170712081344.25495-10-maarten.lankhorst@linux.intel.com>
Message-ID: <5965EEC0.5000302@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?07?12? 16:13, Maarten Lankhorst wrote:
> for_each_obj_in_state is about to be removed, so use the new atomic
> iterator macros.
>
> Signed-off-by: Maarten Lankhorst<maarten.lankhorst@linux.intel.com>
> Cc: Mark Yao<mark.yao@rock-chips.com>
> Cc: Heiko Stuebner<heiko@sntech.de>
> Cc:linux-arm-kernel at lists.infradead.org
> Cc:linux-rockchip at lists.infradead.org

Looks good for me:

Acked-by: Mark Yao <mark.yao@rock-chips.com>
