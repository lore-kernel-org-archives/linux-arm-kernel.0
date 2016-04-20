From: john@metanate.com (John Keeping)
Date: Wed, 20 Apr 2016 12:26:32 +0100
Subject: [PATCH v3] drm/rockchip: get rid of rockchip_drm_crtc_mode_config
In-Reply-To: <1461120102-32054-1-git-send-email-mark.yao@rock-chips.com>
References: <1461119505-27076-1-git-send-email-mark.yao@rock-chips.com>
 <1461120102-32054-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20160420122632.69378803.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2016 10:41:42 +0800, Mark Yao wrote:

> We need to take care of the vop status when use
> rockchip_drm_crtc_mode_config, if vop is disabled,
> the function would failed, that is terrible.
> 
> Save output_type and output_mode into rockchip_crtc_state,
> it's nice to make them into atomic.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

Tested-by: John Keeping <john@metanate.com>
(for HDMI output)
