From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 17:44:15 +0100
Subject: [PATCH] net: hisilicon: fix binding document of mdio
In-Reply-To: <20151113144457.GA18563@rob-hp-laptop>
References: <1447381424-107248-1-git-send-email-huangdaode@hisilicon.com>
 <20151113144457.GA18563@rob-hp-laptop>
Message-ID: <4637718.UGnlN7fHno@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 08:44:57 Rob Herring wrote:
> 
> Please reformat like this:
> 
> - compatible: can be one of:
>         "hisilicon,hns-mdio"
>         "hisilicon,mdio"
>   For hip04 board, must be "hisilicon,mdio".
>   Otherwise, must be "hisilicon,hns-mdio".

should we recommend the use of "hisilicon,hns-mdio" unconditionally
and only list "hisilicon,mdio" for backwards compatibility?

	Arnd
