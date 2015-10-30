From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Oct 2015 15:20:18 +0100
Subject: [PATCH RESEND v2 net-next] net: hisilicon: updates HNS config and
 documents
In-Reply-To: <1445944594-244149-1-git-send-email-huangdaode@hisilicon.com>
References: <1445944594-244149-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <4549013.K7sn8Pca5b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 October 2015 19:16:34 huangdaode wrote:
>           mdio at 803c0000 {
>                     #address-cells = <1>;
>                     #size-cells = <0>;
> -                   compatible = "hisilicon,mdio","hisilicon,hns-mdio";
> +                   compatible = "hisilicon,hns-mdio","hisilicon,mdio";
>                     reg = <0x0 0x803c0000 0x0 0x10000>;
>  
> 

Does "hisilicon,mdio" actually have a specific meaning? Is that just there
for legacy reasons?

	Arnd
