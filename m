From: marek.belisko@gmail.com (Belisko Marek)
Date: Mon, 9 May 2011 21:35:37 +0200
Subject: [PATCH v2 0/4] s3c2440: mini2440: Add missing code parts to be
	fully working with latest kernel.
In-Reply-To: <1302094897-18446-1-git-send-email-marek.belisko@open-nandra.com>
References: <1302094897-18446-1-git-send-email-marek.belisko@open-nandra.com>
Message-ID: <BANLkTikUUUUU90Kd53qW=DyX6f8pdjakdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2011 at 3:01 PM, Marek Belisko
<marek.belisko@open-nandra.com> wrote:
> changes from v1 to v2: Replace original patch [4] with generic leds-gpio driver.
>
> Patch add new LCD panels with which was board produced. Also add touchscreen
> support. Enabling LCD backlight during early booting stage also added.
>
> Some code parts are collected or inspired from other code (authors are in CC).
>
> Marek Belisko (4):
> ?s3c2440: mini2440: Add support for new LCD panels.
> ?s3c2440: mini2440: Add touchscreen support for mini2440.
> ?s3c2440: mini2440: Select touchscreen by default.
> ?s3c2440: mini2440: Use leds-gpio driver for board leds handling.
>
> ?arch/arm/mach-s3c2440/Kconfig ? ? ? ? | ? ?1 +
> ?arch/arm/mach-s3c2440/mach-mini2440.c | ?176 ++++++++++++++++++++-------------
> ?2 files changed, 107 insertions(+), 70 deletions(-)
Sorry but I received no objections on this patches (no objections for
any patch previously send to mach-mini2440).
Ben could you please apply this serie to get full mini2440 support
mainstream or?
>
>

thanks,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
