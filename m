From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 10 Jan 2013 13:57:04 +0100
Subject: [PATCH v2] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <50EEB95E.3070407@free-electrons.com>
References: <1588881.pi23bvqp7D@bender> <3816648.2TVsTiMOWx@bender>
 <50EEB95E.3070407@free-electrons.com>
Message-ID: <50EEBAA0.7070207@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory,

Le 01/10/13 13:51, Gregory CLEMENT a ?crit :
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MB */
> Hi Florian,
>
> As you based your file on our (erroneous) dts, could you confirm that
> the RD-A370-A1 board have "only" 512MB?

Yes it only has 512MB of RAM, this is not a mistake.
--
Florian
