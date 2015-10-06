From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 16:20:23 +0200
Subject: [PATCH v3 0/3] ARM: uniphier: add outer cache support and rework
 SMP operations
In-Reply-To: <1442551054-2116-1-git-send-email-yamada.masahiro@socionext.com>
References: <1442551054-2116-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <6239461.UGe6XP3dfB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 September 2015 13:37:31 Masahiro Yamada wrote:
> Hi Olof,
> 
> Now Linux 4.3-rc1 is out, so I am back to this.
> 
> 1/3: add outer cache support
> 2/3: rework SMP operations
> 3/3: add device tree nodes
> 
> Because 2/3 highly depends on 1/3, I hope whole of this series
> is applied through ARM-SOC tree.

Sorry for the long delay here. Is this the latest version of these
patches?

Did Russell King review the first patch?
Is he ok with merging this through arm-soc?

	Arnd
