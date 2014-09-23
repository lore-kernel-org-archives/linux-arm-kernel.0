From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 16:37:17 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <20140923142922.GE18924@kwain>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140923140113.GC18924@kwain> <20140923142922.GE18924@kwain>
Message-ID: <4014272.rJbSfrLcuB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 16:29:22 Antoine Tenart wrote:
> 
> So I had a look on other Ethernet bindings. Would you agree with
> something like the following?
> 
>         eth0: ethernet at f7b90000 {
>                 ...
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 phy-handle = <&ethphy0>;
> 
>                 ethphy0: ethernet-phy at 0 {
>                         reg = <0>;
>                 };
>         };

Yes, that looks good.

	Arnd
