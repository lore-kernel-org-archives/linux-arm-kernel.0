From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 2 Apr 2017 09:58:17 +0100
Subject: [PATCH v4 1/6] dt-bindings: iio: rockchip-saradc: add support for
 rk3328
In-Reply-To: <1940747.DLKBel529v@phil>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
 <1490607650-18650-2-git-send-email-cl@rock-chips.com>
 <1940747.DLKBel529v@phil>
Message-ID: <3b0bb12e-3f9e-84b8-3d4e-976ace90fe74@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/17 14:25, Heiko Stuebner wrote:
> Hi Jonathan,
> 
> Am Montag, 27. M?rz 2017, 17:40:46 CEST schrieb cl at rock-chips.com:
>> From: Liang Chen <cl@rock-chips.com>
>>
>> The rk3328 saradc is the same as rk3399.
>>
>> Signed-off-by: Liang Chen <cl@rock-chips.com>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> just for planning purposes, do you plan on picking this up or do you
> want me to queue it with the rest of the changes (Ack needed).

Applied to the togreg branch of iio.git.  Makes more sense that
way as we might get some other changes around that file and it
doesn't make any difference to the rest of the series.

Will probably start it's way upstream this afternoon if I get
through the rest of my backlog.

Thanks,

Jonathan
> 
> Heiko
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
