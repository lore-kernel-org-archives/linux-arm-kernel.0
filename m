From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 Mar 2016 10:12:02 +0530
Subject: [PATCH v2] cpufreq: rockchip: add driver
In-Reply-To: <56F40328.5090001@rock-chips.com>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
 <20160323044033.GQ5272@vireshk-i7>
 <56F35894.3020106@rock-chips.com>
 <20160324064324.GG22062@vireshk-i7>
 <56F40328.5090001@rock-chips.com>
Message-ID: <20160325044202.GO22062@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-03-16, 23:09, Finley Xiao wrote:
> --- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
> +       cpufreq {
> +               compatible = "***,***";
> +       }
> 
> Does it create a DT node for a dummy device too ?

Yes, its not allowed.

-- 
viresh
