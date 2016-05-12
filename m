From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 12 May 2016 16:50:54 +0200 (CEST)
Subject: [PATCH 0/4] add minimal bcm2835-sdram driver
In-Reply-To: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1861597197.20753.36a104a6-5284-487f-b397-da7ff0407f1f.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> kernel at martin.sperl.org hat am 12. Mai 2016 um 14:38 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> As the sdram clock is a critical clock to the system
> the minimal bcm2835-sdram driver claims (and enables)
> this clock and also exposes the corresponding sdram
> registers via debugfs.

sounds like this driver should fix an clock handling issue. Unfortunately this
isn't a solution in case the driver is disabled.

Does the GPU firmware handle the SDRAM controller or is it initialized by
bootcode?

Stefan
