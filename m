From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2011 22:18:41 +0200
Subject: [RFC PATCH 0/3] Per SoC descriptor
In-Reply-To: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
References: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <8605786.uz70QLLSTu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011 18:00:09 Marc Zyngier wrote:
> This is my first stab at an idea that has floated around for a while,
> which is to have a per-soc descriptor containing most of the SoC
> specific operations, which should clear the path a bit more towards
> the single zImage holy grail. It's as far as possible from being
> perfect, but I thought I'd share it as early as possible and see what
> people think of it.
> 
> This first patch series introduces the arm_soc_desc structure, adds
> per-soc SMP and CPU hotplug operations, and converts both RealView and
> VExpress to this new scheme.

Very nice, I definitely like the concept! This is going to be really
helpful reducing the amount of stuff we need in machine descriptors.

	Arnd
