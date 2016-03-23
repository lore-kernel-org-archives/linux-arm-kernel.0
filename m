From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 23 Mar 2016 09:08:21 +0800
Subject: [PATCH v14 09/17] drm: rockchip: dp: add rockchip platform dp
 driver
In-Reply-To: <1455534640-1877-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1455534640-1877-1-git-send-email-ykk@rock-chips.com>
Message-ID: <56F1EC85.8030403@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?02?15? 19:10, Yakir Yang wrote:
> Rockchip have three clocks for dp controller, we leave pclk_edp
> to analogix_dp driver control, and keep the sclk_edp_24m and
> sclk_edp in platform driver.
>
> Signed-off-by: Yakir Yang<ykk@rock-chips.com>
> Tested-by: Javier Martinez Canillas<javier@osg.samsung.com>

It looks good for me, I like it, So

Acked-by: Mark Yao <mark.yao@rock-chips.com>

-- 
?ark Yao
