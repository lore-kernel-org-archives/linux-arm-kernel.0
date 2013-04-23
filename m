From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Apr 2013 11:01:46 -0700
Subject: [PATCH 05/21] ARM: OMAP2+: add dependencies on ARCH_MULTI_V6/V7
In-Reply-To: <1366734653-488286-6-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-6-git-send-email-arnd@arndb.de>
Message-ID: <20130423180146.GI10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130423 09:36]:
> CONFIG_ARCH_OMAP2PLUS depends on (ARCH_MULTI_V6 || ARCH_MULTI_V7) as of
> a0694861 "ARM: OMAP2+: Enable ARCH_MULTIPLATFORM support", but the
> individual OMAP2/3/4/5 and AM33XX platforms can all be selected independent
> of what we are building for, which is a bug and prevents us from easily
> building e.g. an ARMv7-only defconfig.
> 
> This makes ARCH_OMAP2 depend on ARCH_MULTI_V6 and the others depend on
> ARCH_MULTI_V7, to ensure we really only build the platforms for the
> CPUs we have enabled in the global multiplatform configuration step.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Acked-by: Tony Lindgren <tony@atomide.com>
