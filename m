From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Jun 2014 05:07:13 -0700
Subject: [PATCH] ARM: OMAP2+: drop unused function
In-Reply-To: <1402435596-5486-1-git-send-email-computersforpeace@gmail.com>
References: <1402435596-5486-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <20140616120712.GJ17845@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Brian Norris <computersforpeace@gmail.com> [140610 14:31]:
> gic_init_irq() is no longer used as of:
> 
>     commit b42b918194c4791510ac049e3d507169a7de8544
>     Author: Tony Lindgren <tony@atomide.com>
>     Date:   Thu May 30 12:53:05 2013 -0700
> 
>         ARM: OMAP2+: Remove board-omap4panda.c
> 
> Drop it.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applying into omap-for-v3.16/fixes thanks.

Tony
