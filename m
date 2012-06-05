From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 5 Jun 2012 16:47:40 +0200
Subject: [PATCH 0/4] ARM: at91: introduce AIC5 support
Message-ID: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches introduces AIC5 support with the goal to have only one
kernel image for all SOCs.
AIC5 can manage up to 128 irq lines and introduces a new register map and
a source select register to select the IRQ line we want to configure.

Regards

Ludovic
