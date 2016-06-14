From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 14 Jun 2016 11:02:09 +0800
Subject: [PATCH] clk: rockchip: add pclk_vio_grf to critical clock on the
 RK3399
In-Reply-To: <CAD=FV=WhaN__psCV_hYoc67gZMpCt_9yp5=vR-C4uc8i39RAaA@mail.gmail.com>
References: <1465724913-14553-1-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=XSSPMOnMD3mqFyqM3wWLShbRc2cXVdN0PYcUxpaDnsTw@mail.gmail.com>
 <575E240C.9060502@rock-chips.com>
 <CAD=FV=WhaN__psCV_hYoc67gZMpCt_9yp5=vR-C4uc8i39RAaA@mail.gmail.com>
Message-ID: <575F73B1.9000703@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 2016?06?14? 07:46, Doug Anderson wrote:
>
> Even if it's not much power, it seems like we should still turn it off
> and on in the right place.  Unless I'm mistaken it should be such a
> simple patch provide the clock to the right driver and then get the
> clock when appropriate.
Yes, I talked with Yakir and we intent to enable/disable the 
pclk_vio_grf in video drivers,
so this patch will be dropped.
>> I will refer the latest TRM to update a new patch for always enable these
>> GRFs.
> Does that mean you're going to make these all critical clocks?  That
> doesn't sound so great...
>
> -Doug
Maybe, I heard that they are removed in the updated TRM, but I have not 
got the TRM yet.
I will double check it, and it seems that you do not agree to remove 
these clock...

Thanks.

-- 
- Xing Zheng
