From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Apr 2014 16:52:04 +0200
Subject: [PATCH v2 22/38] ARM: orion: switch to a per-platform
 handle_irq() function
In-Reply-To: <B3DF11DE-D10F-41EB-BE40-2C26DA3BF719@lakedaemon.net>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-23-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140426145457.GV28159@titan.lakedaemon.net>
 <535BD3F1.8000706@gmail.com>
 <B3DF11DE-D10F-41EB-BE40-2C26DA3BF719@lakedaemon.net>
Message-ID: <20140429165204.20ac98be@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Sat, 26 Apr 2014 16:33:01 -0400, Jason Cooper wrote:

> > Jason,
> > 
> > adding a missing #include <asm/exception.h> fixes the build issue.
> > Can you squash adding it in?
> > 
> 
> Yep, that fixed it.  Entire gamut of build tests have passed.  So I squashed it into this patch and push the series out to mvebu/soc-orion5x

Great, thanks! And thanks a lot to Sebastian for fixing the build issue.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
