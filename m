From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Mar 2013 16:38:27 +0000
Subject: [PATCH 1/6] arm: vt8500: Increase available GPIOs on arch-vt8500
In-Reply-To: <1362807578-23089-2-git-send-email-linux@prisktech.co.nz>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130311163826.GJ4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 09, 2013 at 06:39:33PM +1300, Tony Prisk wrote:
> With the inclusion of the pin control driver, more GPIO pins have been
> identified on the arch-vt8500 SoCs requiring an increase in the available
> GPIOs.

There is a patch from Maxime Ripard in February fixing the broken
orering of these options.  It was sent to Arnd and Olof - but was it
merged?  Arnd/Olof needs to merge for -rc and people need to take
note of it (it will conflict for example with your patch.)
