From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 31 Aug 2012 06:12:09 +0200
Subject: [PATCH 03/10] serial: atmel: add explict mach/gpio.h include
In-Reply-To: <1346279496-26286-4-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120831041209.GD7629@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:31 Wed 29 Aug     , Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to remove implicit inclusion of mach/gpio.h, add explicit
> include of mach/gpio.h.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Alan Cox <alan@linux.intel.com>
no you do not fix the right way

we need to use the gpio lig in this driver

Best Regards,
J.
