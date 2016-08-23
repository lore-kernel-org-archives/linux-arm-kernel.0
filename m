From: jic23@kernel.org (Jonathan Cameron)
Date: Tue, 23 Aug 2016 19:08:51 +0100
Subject: [PATCH v3 3/4] arm64: dts: rockchip: add reset saradc node for
 rk3368 SoCs
In-Reply-To: <1802628.7aG4jhMeVI@phil>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <1469629447-544-3-git-send-email-wxt@rock-chips.com>
 <1802628.7aG4jhMeVI@phil>
Message-ID: <a2d2892c-60d6-15a4-cc6b-2dce292812b8@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/16 18:19, Heiko Stuebner wrote:
> Am Mittwoch, 27. Juli 2016, 22:24:06 CEST schrieb Caesar Wang:
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Cc: <Stable@vger.kernel.org>
Thanks,

Applied to the fixes-togreg branch of iio.git.

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
