From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 10 Nov 2009 07:49:00 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>
References: <20091104131500.GZ14091@buzzloop.caiaq.de>
	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
	<OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>
Message-ID: <20091110064900.GK14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2009 at 11:12:03AM +0530, Vadivelan M wrote:
>    I have checked the inittab. the baud rate is correct.
> 
>    When i am passing command line arguments "init=bin/sh
>    consloe=ttymxc0,115200 root=/dev/ram rw ip=off"
> 
>    same status. i can see the print Freeing init memory and some uart
>    function prints...
> 
>    After that only junk characters are coming.
> 
>    we have checked serial drivers . almost no changes between 2.6.19(working
>    kernel) and 2.6.27
> 
>    Please help us to go forward.....

Sorry, I don't know then. I was sure you're facing a baud rate issue,
which also is a common pitfall.

Can you try using a current mainline git kernel and see if the problem
persists? Your machine type (MX27ADS) should be supported.

Daniel
