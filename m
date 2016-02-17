From: jbe@pengutronix.de (Juergen Borleis)
Date: Wed, 17 Feb 2016 12:10:14 +0100
Subject: Using i.MX6 quad's IPU#1/DI#1 to drive parallel port #1 failed
Message-ID: <201602171210.14545.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

someone here who has a working display (or similar) connected to i.MX6 quad's 
parallel port #1 and driven by IPU#1/DI#1? It seems there is currently no user 
in the mainline supported boards.

In my application the RGB data signals seem present, HSYNC and VSYNC as well 
(with the expected timing), but the display clock and the DE signals are 
missing. We already double checked the pin muxing and the physical connection 
(for example muxing the clock pad to be a GPIO works as expected).

Are there any known restrictions?

Thanks in advance.
Juergen
