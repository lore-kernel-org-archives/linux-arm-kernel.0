From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 08 Apr 2015 18:51:32 +0800
Subject: [PATCH v2] ASoC: max98090: add shutdown callback for max98090
In-Reply-To: <1428488311-27237-1-git-send-email-wxt@rock-chips.com>
References: <1428488311-27237-1-git-send-email-wxt@rock-chips.com>
Message-ID: <55250834.8040208@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

On 04/08/2015 06:18 PM, Caesar Wang wrote:
> To fix pop noise when shutdown,the pop noise during shutdown
> is the pmic cutoff power of codec without any notice.
>
> Signed-off-by: jay.xu <xjq@rock-chips.com>
> Signed-off-by: zhengxing <zhengxing@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> Serien-cc: linux-kernel at vger.kernel.org
> Serien-cc: devicetree at vger.kernel.org
> Serien-cc: dianders at chromium.org
Typo? Should be "Series-cc" here I guess.

Thanks,
- Kever
