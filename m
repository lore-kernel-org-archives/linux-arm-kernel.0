From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 Aug 2012 08:39:22 -0700
Subject: [PATCH 08/10] ARM: omap2: add explict mach/gpio.h includes
In-Reply-To: <1346279496-26286-9-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-9-git-send-email-robherring2@gmail.com>
Message-ID: <20120831153921.GK1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [120829 15:32]:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to remove implicit inclusion of mach/gpio.h, add explict
> include of mach/gpio.h.

Just for reference, as Rob already mentioned, these should no longer be
needed for omaps after the "Clean up hardcoded IRQs for mach-omap2,
enable SPARSE_IRQ, plaform_data/gpio-omap.h" series I posted yesterday.

Regards,

Tony
