From: andy@warmcat.com (Andy Green)
Date: Tue, 10 Nov 2009 09:14:22 +0000
Subject: imx27 - hanging at freeing init memory -- getting some
	junk	characters here after on console ..
In-Reply-To: <20091110064900.GK14091@buzzloop.caiaq.de>
References: <20091104131500.GZ14091@buzzloop.caiaq.de>	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>	<OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>
	<20091110064900.GK14091@buzzloop.caiaq.de>
Message-ID: <4AF92EEE.6000208@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/09 06:49, Somebody in the thread at some point said:

Hi -

>>     I have checked the inittab. the baud rate is correct.

> Sorry, I don't know then. I was sure you're facing a baud rate issue,
> which also is a common pitfall.

Vadivelan, it won't hurt to put an oscilloscope on the UART output and 
measure the smallest bit-time you see.

For 115200 it's 8.68us, if you see something different after the trash 
comes maybe you can get a clue from the measured period of the junk vs 
8.68us expected.

-Andy
