From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Dec 2017 08:39:57 -0800
Subject: [PATCH 18/25] arm: am3/am4/dra7/omap: dts: Remove leading 0x and
 0s from bindings notation
In-Reply-To: <20171215124651.30793-1-malat@debian.org>
References: <20171215124651.30793-1-malat@debian.org>
Message-ID: <20171215163957.GC3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mathieu Malaterre <malat@debian.org> [171215 04:49]:
> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> following dtc warnings:
> 
> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
> 
> and
> 
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Thanks applying this patch into omap-for-v4.16/dt.

Regards,

Tony
