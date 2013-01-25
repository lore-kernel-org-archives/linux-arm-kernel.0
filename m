From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 25 Jan 2013 15:22:40 +0100
Subject: [PATCHv1 for soc 1/5] arm: socfpga: Add new device tree source
 for actual socfpga HW
In-Reply-To: <1359075633-13502-2-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-2-git-send-email-dinguyen@altera.com>
Message-ID: <20130125142240.GB10055@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Up to this point, support for socfpga has only been on a virtual
> platform. Now that actual hardware is available, we add the appropriate
> device tree source files.

Wow, actual hardware :-). Can I get one?

> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>

I tested it on 3.7-rc2-based tree, as it is newest I have around. It
seems to work ok. [Do you have newer git tree somewhere?]

Tested-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Pavel Machek <pavel@denx.de>

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
