From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Dec 2011 13:45:01 +0800
Subject: [PATCH V2 1/2] pinctrl: enable pinmux for pxa series
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1751860B1F@HQMAIL01.nvidia.com>
References: <1323769253-22580-1-git-send-email-haojian.zhuang@marvell.com>
 <1323769253-22580-2-git-send-email-haojian.zhuang@marvell.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1751860B1F@HQMAIL01.nvidia.com>
Message-ID: <CAN1soZyZ79cozpYTYC+L4K-qL0MjyvO49m=5iKNDdS0nRUYJPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 2:28 AM, Stephen Warren <swarren@nvidia.com> wrote:
> See the Tegra patches I posted for example.
>
>> +++ b/drivers/pinctrl/pinmux-pxa300.c
> ...
>> + * ?linux/drivers/pinctrl/pinmux-pxa3xx.c
>
> The comment doesn't match the filename.
>
>> diff --git a/drivers/pinctrl/pinmux-pxa910.c b/drivers/pinctrl/pinmux-pxa910.c
>
> Same comment for this file; it appears to contain the data for two
> different CPUs, and there's no commonality.
>
> --
> nvpublic
>
There's some common code in pxa910 & mmp2 on pin configuration. But
pinconf-generic driver isn't ready now.
