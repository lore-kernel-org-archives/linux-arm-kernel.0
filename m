From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 21 Jun 2017 14:36:52 +0800
Subject: [PATCH v2 1/2] drm/rockchip: add const to
 drm_encoder_helper_funcs structures
In-Reply-To: <1498026670-10671-3-git-send-email-bhumirks@gmail.com>
References: <1498026670-10671-1-git-send-email-bhumirks@gmail.com>
 <1498026670-10671-3-git-send-email-bhumirks@gmail.com>
Message-ID: <594A1404.2070408@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?06?21? 14:31, Bhumika Goyal wrote:
> Add const to drm_encoder_helper_funcs structures as they are only passed
> as an argument to the function drm_encoder_helper_add and this argument
> is of type const. So, add const to these structures.
>
> Signed-off-by: Bhumika Goyal<bhumirks@gmail.com>
> ---
> Changes in v2 -
> * Let the line exceed over 80 characters while adding const.

Acked-by: Mark Yao <mark.yao@rock-chips.com>

Thanks

-- 
?ark Yao
