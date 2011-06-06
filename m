From: zecke@selfish.org (Holger Freyther)
Date: Mon, 06 Jun 2011 17:32:59 +0200
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <alpine.LFD.2.02.1106061719290.13964@ionos>
References: <4DECCADE.6080100@selfish.org> <4DECD8C0.6010908@freyther.de>
	<alpine.LFD.2.02.1106061650210.13964@ionos>
	<4DECEDF9.4010202@selfish.org>
	<alpine.LFD.2.02.1106061719290.13964@ionos>
Message-ID: <4DECF32B.6000508@selfish.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2011 05:25 PM, Thomas Gleixner wrote:

> Crap, yes. The code which does the chained handler setup overwrites
> chip_data.
> 

Ah, you were too fast in the end, I just finished reading linux/irq.h. :)



> Subject: arm: davinci: Fix fallout from generic irq chip conversion
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 06 Jun 2011 11:51:43 +0200
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Holger Hans Peter Freyther <holger@freyther.de>
