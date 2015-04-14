From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 15:20:28 +0200
Subject: [PATCH v2 3/6] clk: hi6220: Document devicetree bindings for
 hi6220 clock
In-Reply-To: <552D09F7.7080603@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <2456827.cDpE8M58pn@wuerfel> <552D09F7.7080603@huawei.com>
Message-ID: <5065055.RUNnjWsHWj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 20:37:11 Bintian wrote:
> It's really a smart fix!
> 
> For the four system controllers, how about change the following strings:
> +       - "hisilicon,aoctrl"
> +       - "hisilicon,sysctrl"
> +       - "hisilicon,mediactrl"
> +       - "hisilicon,pmctrl"
> 
> to
> +       - "hisilicon,hi6220-aoctrl"
> +       - "hisilicon,hi6220-sysctrl"
> +       - "hisilicon,hi6220-mediactrl"
> +       - "hisilicon,hi6220-pmctrl"

Yes, that works.

> and I also use "hisilicon,hi6220-xxxx" for hi6220 clk driver directly ?

Seems fine to me, though I'd have to look at the bigger picture to see
any potential problems. At the moment, I don't see any.

	Arnd
