From: sz.lin@moxa.com (SZ Lin =?utf-8?B?KOael+S4iuaZuik=?=)
Date: Fri, 24 Aug 2018 13:50:01 +0800
Subject: [PATCH] Add DT support for Octavo Systems OSD3358-SM-RED based
 on TI AM335x
In-Reply-To: <20180713163314.1099-1-neeraj.dantu@octavosystems.com>
References: <20180713163314.1099-1-neeraj.dantu@octavosystems.com>
Message-ID: <20180824055001.GA19335@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

<snip>

> diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
> new file mode 100755

I think the permission here should be 100644 instead of 100755.

> index 0000000..4d96901
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts

-- 
SZ Lin (???) 
