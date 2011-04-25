From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Apr 2011 12:13:58 +0200
Subject: arm: msm: Convert irq-vic to generic irq chip
In-Reply-To: <4DB51094.3040003@codeaurora.org>
References: <20110416211221.853079766@linutronix.de>
	<20110416211308.455390167@linutronix.de>
	<4DB0611D.6040902@codeaurora.org>
	<alpine.LFD.2.02.1104211926550.3323@ionos>
	<4DB51094.3040003@codeaurora.org>
Message-ID: <BANLkTimna8fnWcZskWnLE6U8zE0SUhY87g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/25 Abhijeet Dharmapurikar <adharmap@codeaurora.org>:

> - the common one uses some PL190 registers, not sure what that is.

PL190 is ARMs name for the VIC: PrimeCell 190.

Every vendor get these PrimeCells as part of their bargin for CPU
cores when licensing ARM IP. Then they tweak them to suit their
needs and fix hardware bugs.

It seems Qualcomm HW engineers did the same thing as everyone
else, tweak a PrimeCell by editing VHDL until it works...

Yours,
Linus Walleij
