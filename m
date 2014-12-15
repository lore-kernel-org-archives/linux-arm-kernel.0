From: richard@sigma-star.at (Richard Weinberger)
Date: Mon, 15 Dec 2014 23:47:48 +0100
Subject: at91: smc configuration using DT
Message-ID: <548F6514.1040706@sigma-star.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm sure I'm missing something.

One of my boards is still using board files and uses sam9_smc_configure() to
setup NAND timings. I'd like to convert it to DT but I fail to see how to configure the smc.
What is the device tree equivalent of sam9_smc_configure()?

Thanks,
//richard

-- 
sigma star gmbh - Bundesstrasse 3 - 6111 Volders - Austria
ATU66964118 - FN 374287y
