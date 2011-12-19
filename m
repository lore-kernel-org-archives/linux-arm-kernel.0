From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 11:08:27 -0800
Subject: [PATCH 19/20] ARM: substitute arch_idle()
In-Reply-To: <1324288069-21940-20-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-20-git-send-email-nico@fluxnic.net>
Message-ID: <20111219190827.GL6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111219 01:43]:
> Now that all implementations of arch_idle() are equivalent to cpu_do_idle()
> we can just use the later directly and stop including mach/system.h.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Tony Lindgren <tony@atomide.com>
