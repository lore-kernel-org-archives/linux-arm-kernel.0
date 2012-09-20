From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Sep 2012 12:48:28 +0000
Subject: [PATCH v4] gpio: mvebu: new gpio driver for mvebu platforms
In-Reply-To: <1348087983-22309-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1348087983-22309-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201209201248.29390.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 September 2012, Thomas Petazzoni wrote:
> This patch set adds a new GPIO driver for Marvell EBU SoCs, which aims
> at replacing the existing GPIO driver from plat-orion/gpio.c. The
> driver comes with the necessary DT changes to make it work on Armada
> 370 and Armada XP, and it has been tested successfully by Sebastian
> Hesselbarth on Dove. It should also work flawlessly on other Marvell
> EBU SoCs (Kirkwood, Orion, Discovery), but this remains to be tested
> by the relevant maintainers. This isn't however a problem, as those
> older platforms need to explictly be converted over to the new pinctrl
> driver and the new gpio driver. Until that, they will happily continue
> to use the old, known-working gpio driver. So this patch set has no
> chance to break any of the existing Marvell platforms.

Acked-by: Arnd Bergmann <arnd@arndb.de>
