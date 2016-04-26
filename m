From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Tue, 26 Apr 2016 11:36:04 +0530
Subject: [PATCH v2 2/2] phy: Group vendor specific phy drivers
In-Reply-To: <1459951665-28708-2-git-send-email-gautam.vivek@samsung.com>
References: <1459951665-28708-1-git-send-email-gautam.vivek@samsung.com>
 <1459951665-28708-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CAFp+6iHGSuTGbyWv4dV3GCNr=7VDRnBpcodwnoeB1i0zocUg5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,


On Wed, Apr 6, 2016 at 7:37 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
>
> Also updated the MAINTAINERS file to reflect the correct
> directory structure for phy drivers.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>
> Changes from v1:
>  - Updated the MAINTAINERS file to reflect the same change
>    in directory structure.
>  - Removed PHY_PLAT config as pointed out by Kishon.
>    So we don't require the second patch in the v1 of this series:
>    [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
>  - Renamed sunxi --> allwinner; rcar --> renesas.
>  - Fixed error coming with qcom Makefile.

Does this change looks okay now ?
I think you must be planning to take this in after 4.7 rc1 is out, isn't it ?

[skip]


-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
