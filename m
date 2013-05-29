From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 15:33:13 +0200
Subject: [PATCH 3/3] ARM PJ4B: Add support for errata 4611
In-Reply-To: <51A60243.3000800@free-electrons.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <4523769.Zp7B72tmfz@wuerfel> <51A60243.3000800@free-electrons.com>
Message-ID: <2479964.1Q22eHuH4J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013 15:27:31 Gregory CLEMENT wrote:
> OK I will see what kind of information I can gather and which ones I can
> add to the Documentation/arm/Marvell/README file.
> 
> My current understanding is that there are at least 3 kind of CPU:
> PJ4, PJ4B and PJ4B-MP and all of them belongs to the Sheeva family.

Ok. So I guess PJ4B adds LPAE support, and PJ4B-MP adds SMP support,
right? Do either of them support hypervisor mode?

Regarding the errata: are those needed for production-level chips,
or just for prototypes?

	Arnd
