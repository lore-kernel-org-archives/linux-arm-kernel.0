From: pavel@denx.de (Pavel Machek)
Date: Fri, 1 Feb 2013 11:50:47 +0100
Subject: [PATCHv2 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1359651943-21752-5-git-send-email-dinguyen@altera.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-5-git-send-email-dinguyen@altera.com>
Message-ID: <20130201105047.GB3124@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2013-01-31 11:05:43, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Because the CPU1 start address is different for socfpga-vt and
> socfpga-cyclone5, we add code to use the correct CPU1 start addr.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
Signed-off-by: Pavel Machek <pavel@denx.de>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
