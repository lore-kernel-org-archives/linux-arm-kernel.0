From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Apr 2015 17:32:35 +0200
Subject: [PATCH v2 3/6] clk: hi6220: Document devicetree bindings for
 hi6220 clock
In-Reply-To: <1428916660-25910-4-git-send-email-bintian.wang@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <1428916660-25910-4-git-send-email-bintian.wang@huawei.com>
Message-ID: <7304398.GVjUsTVoce@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 April 2015 17:17:37 Bintian Wang wrote:
> +- compatible: the compatible should be one of the following strings to
> +       indicate the clock controller functionality.
> +
> +       - "hisilicon,aoctrl"
> +       - "hisilicon,sysctrl"
> +       - "hisilicon,mediactrl"
> +       - "hisilicon,pmctrl"
> +
> 

These ones already have bindings, you can't reuse the strings.
Please work with someone in hisilicon to set up a registry of
device names so you can avoid conflicts in the future.

	Arnd
