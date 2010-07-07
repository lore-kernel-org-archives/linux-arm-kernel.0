From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jul 2010 13:52:14 +0300
Subject: OK to base some patches on lmb branch?
Message-ID: <20100707105213.GJ1920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Is your lmb branch going to stay static?

I'd like to base a patch unifying omap3 map_io on top of that
to avoid merge conflicts:

https://patchwork.kernel.org/patch/108775/

Otherwise it will conflict with your LMB related patch
"Convert to use ->reserve method to reserve boot time memory".

Regards,

Tony
