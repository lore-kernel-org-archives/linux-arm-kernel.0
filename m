From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Dec 2011 10:16:25 -0800
Subject: [PATCH v4 REPOST 2/5] ARM: SMP: Refactor Kconfig to be more
 maintainable
In-Reply-To: <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
Message-ID: <20111214181624.GD32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Martin <dave.martin@linaro.org> [111214 03:08]:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines.  To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.

For omap:

Acked-by: Tony Lindgren <tony@atomide.com>
