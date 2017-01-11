From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 11 Jan 2017 10:02:49 +0800
Subject: [PATCH v4 1/2] arm64: dts: rockchip: add "rockchip, grf" property
 for RK3399 PMUCRU/CRU
In-Reply-To: <1799437.apf7OqdtKq@phil>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=Wwu3q_LqwYUWcJQRvp5neVOS9szgsYFONWTRJ0X8hRTA@mail.gmail.com>
 <58758498.40309@rock-chips.com> <1799437.apf7OqdtKq@phil>
Message-ID: <58759249.4020808@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2017?01?11? 09:12, Heiko Stuebner wrote:
>> I just woud like to add this patch to avoid getting some unavailable
>> MUXGRF clock and need to debug it again,
>> if we support it one day in future.
> could you just check, if we have any other grf-based muxes that we may need in
> the future. Right now I only see pclkin_isp1_wrapper describing such a mux,
> but it would be cool if you could check again.
>
>
OK, we will check these.  :)

Thanks.

-- 
- Xing Zheng
