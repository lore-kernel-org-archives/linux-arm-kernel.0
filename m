From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 13 Jan 2017 20:10:54 +0100
Subject: [PATCH v4 0/2] Add support rockchip,
 grf property for RK3399 PMU/GRU
In-Reply-To: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <3210111.1N6x2AkRMx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. Januar 2017, 14:15:28 CET schrieb Xing Zheng:
> Hi,
>   The structure rockchip_clk_provider needs to refer the GRF regmap
> in somewhere, if the CRU node has not "rockchip,grf" property,
> calling syscon_regmap_lookup_by_phandle will return an invalid GRF
> regmap, and the MUXGRF type clock will be not supported.
> 
> Therefore, we need to add them.
> 
> Thanks.

applied both for 4.11

binding-change is in my clock-branch (so that dt-binding doc changes stay 
together) and the dts change is of course in the dts64 branch.


Thanks
Heiko
