From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Mar 2014 08:37:19 +0000
Subject: [PATCH] regulator: Add new driver for ST's PWM controlled
 voltage regulators
In-Reply-To: <20140321182039.GQ552@sirena.org.uk>
References: <1395397296-8196-1-git-send-email-lee.jones@linaro.org>
 <20140321182039.GQ552@sirena.org.uk>
Message-ID: <20140324083719.GJ8541@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On some STMicroelectronics hardware reside regulators consisting
> > partly of a PWM input connected to the feedback loop. As the PWM
> > duty-cycle is varied the output voltage adapts. This driver
> > allows us to vary the output voltage by adapting the PWM input
> > duty-cycle.
> 
> Applied, thanks.  Please send incremental fixes for the things Josh
> mentioned.

Looks like Axel was bored.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
