From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 21 Jan 2016 08:51:58 +0800
Subject: [PATCH v2 0/3] drm/rockchip: fix cursor performance with atomic
In-Reply-To: <cover.1453200263.git.john@metanate.com>
References: <cover.1452782114.git.john@metanate.com>
 <cover.1453200263.git.john@metanate.com>
Message-ID: <56A02BAE.1050009@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?01?19? 18:46, John Keeping wrote:
> The first two patches are unchanged since v1 but the comment in the
> third has been expanded following Thierry's comments.
>
> John Keeping (3):
>    drm/atomic-helper: Export framebuffer_changed()
>    drm/rockchip: don't wait for vblank if fb hasn't changed
>    drm/rockchip: explain why we can't wait_for_vblanks
>
>   drivers/gpu/drm/drm_atomic_helper.c        | 24 ++++++++++++++++++++----
>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 23 +++++++++++++++++++++--
>   include/drm/drm_atomic_helper.h            |  4 ++++
>   3 files changed, 45 insertions(+), 6 deletions(-)
>

Hi John

Thanks for your fix, applied these three patches into my drm-next, :-)

-- 
?ark Yao
