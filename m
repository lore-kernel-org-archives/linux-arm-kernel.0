From: jic23@kernel.org (Jonathan Cameron)
Date: Tue, 23 Aug 2016 19:09:59 +0100
Subject: [PATCH v3 4/4] arm: dts: rockchip: add reset node for the exist
 saradc SoCs
In-Reply-To: <2485357.yNPXRzbCnj@phil>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-4-git-send-email-wxt@rock-chips.com>
 <2485357.yNPXRzbCnj@phil>
Message-ID: <bd4ebfaa-27e2-5e6c-64f3-62290a8ba3de@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/16 18:20, Heiko Stuebner wrote:
> Am Mittwoch, 27. Juli 2016, 22:24:07 CEST schrieb Caesar Wang:
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Cc: <Stable@vger.kernel.org>
> 
Applied to the fixes-togreg branch of iio.git

I'll probably get the pull request done tonight to get this on it's
way.

Jonathan
