From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Feb 2014 21:14:44 +0100
Subject: [PATCH v2 12/23] ARM: Fix default CPU selection for ARCH_MULTI_V5
In-Reply-To: <1392459621-24003-13-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-13-git-send-email-andrew@lunn.ch>
Message-ID: <201402152114.45015.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 February 2014, Andrew Lunn wrote:
> CPU_ARM926T should be selected if no other CPU is. Put the ! in the
> right place so this works.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
