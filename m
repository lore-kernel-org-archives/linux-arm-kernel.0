From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Sun, 15 Dec 2013 22:44:14 +0100
Subject: [linux-sunxi] Re: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
In-Reply-To: <52ADBD41.4050104@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-3-git-send-email-hdegoede@redhat.com>
 <20131215135854.GF3651@lukather> <52ADBD41.4050104@redhat.com>
Message-ID: <1387143854.1559.1.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s?n 2013-12-15 klockan 15:31 +0100 skrev Hans de Goede:

> Yes and no. The pullups are enabled by uboot and the allwinner
> sources, most of my testing has been done without them, which
> seems to work fine. I've enabled them to be consisten with the
> allwinner sources and u-boot.

Many boards have external pullups where needed for the MMC bus. On such
boards it's likely not a good idea to enable internal pullups.

Regards
Henrik
