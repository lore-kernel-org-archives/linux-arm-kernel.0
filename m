From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 13:58:05 +0200
Subject: [PATCH v2 0/3] ARM: aspeed: add support for the BT IPMI interface
In-Reply-To: <1474022367-21029-1-git-send-email-clg@kaod.org>
References: <1474022367-21029-1-git-send-email-clg@kaod.org>
Message-ID: <2566577.tsq2Sf5xZr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 12:39:24 PM CEST C?dric Le Goater wrote:
> 
> C?dric Le Goater (2):
>   ARM: aspeed: Add defconfigs for CONFIG_ASPEED_BT_IPMI_BMC
>   ARM: dts: aspeed: Enable BT IPMI BMC device

These two should go through the arm-soc tree, I assume Joel
will forward them to arm at kernel.org once the driver gets
picked up into the ipmi tree.

	Arnd
