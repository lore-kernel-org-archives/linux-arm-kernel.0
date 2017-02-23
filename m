From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 23 Feb 2017 14:03:04 +0100
Subject: [PATCH V2] ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
In-Reply-To: <20170223125612.2394-1-zajec5@gmail.com>
References: <20170223104025.5755-1-zajec5@gmail.com>
 <20170223125612.2394-1-zajec5@gmail.com>
Message-ID: <b87821b6-57a5-e8cc-eeac-1b0e42ee50f1@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rafal,

On 2017-02-23 13:56, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> It's tri-band wireless home router based on BCM47094 AKA BCM4709C0. It
> uses 3 x BCM4366 chipsets for wireless.
> Panamera seems to be board name used by Linksys.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
> V2: Use panamera board name

My bad, forgot to mention that you should also use "linksys,panamera" as 
a compatibility name as well. "model" should stay as-is of course.



Best,

Imre
