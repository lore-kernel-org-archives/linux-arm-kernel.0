From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 16 Feb 2016 08:39:09 +0800
Subject: [PATCH v2 15/17] drm/rockchip: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <cae559aa2c04a906c21ed5ebe4861f92440e6910.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
 <cae559aa2c04a906c21ed5ebe4861f92440e6910.1455540137.git.palminha@synopsys.com>
Message-ID: <56C26FAD.5040102@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?02?15? 21:01, Carlos Palminha wrote:
> mode_fixup function for encoder drivers became optional with patch
> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com
>
> This patch set nukes all the dummy mode_fixup implementations.
>
> (made on top of Daniel topic/drm-misc branch)
>
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 8 --------
>   1 file changed, 8 deletions(-)
>
>
Acked-by: Mark Yao <mark.yao@rock-chips.com>

Thanks
Mark
