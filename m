From: zhengxing@rock-chips.com (zhengxing)
Date: Thu, 16 Jul 2015 19:59:07 +0800
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <1437047374.28351.8.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl> <55A79394.5090905@rock-chips.com>
 <1437047374.28351.8.camel@tiscali.nl>
Message-ID: <55A79C8B.7020402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
     I mean that the use of MODALIAS() in this patch, and I refered to 
tegra_max98090.c(have been upstreamed) that used it like this also. So I 
didn't care the using.

Thanks.

On 2015?07?16? 19:49, Paul Bolle wrote:
> Hi,
>
> On do, 2015-07-16 at 19:20 +0800, zhengxing wrote:
>>> Did I miss something? Or is there another way this alias is useful
>>> here?
>> Yes, I didn't care about this but I think it maybe correct.
> What is correct: my comment or the use of MODALIAS() in this patch?
>
> Thanks,
>
>
> Paul Bolle
>
>
>
