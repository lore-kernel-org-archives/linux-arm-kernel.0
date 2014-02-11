From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Feb 2014 21:59:16 +0100
Subject: [PATCH 02/12] power/reset: vexpress: Use udelay instead of timers
In-Reply-To: <1392138636-29240-3-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-3-git-send-email-pawel.moll@arm.com>
Message-ID: <201402112159.16758.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 February 2014, Pawel Moll wrote:
> At this stage of system shutdown procedure the jiffies may
> not be updated anymore, so just use udelay instead.

comment doesn't match code: s/udelay/mdelay/

> +                       mdelay(1000);
>         }

	Arnd
