From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jul 2011 18:20:41 +0200
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <4E1DAC3E.4030804@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<201107131542.37432.arnd@arndb.de> <4E1DAC3E.4030804@linaro.org>
Message-ID: <201107131820.41183.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 July 2011, Lee Jones wrote:
> Does this have to be coded and submitted with this patch-set? Is there
> any way we can accept this one and I'll take this reorganisation of
> platform drivers as an action to be completed when I have some more
> spare cycles?

I prefer to remain strict on this one. I don't mind the first
patch getting in now, but I wouldn't want to set a precedent
on incorrect usage of the soc nodes. Note that doing this right
will become a lot easier once the platform has been converted
into device tree probing, because that implies a hierarchical
view of the devices by nature.

	Arnd
