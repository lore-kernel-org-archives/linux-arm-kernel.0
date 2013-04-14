From: pavel@denx.de (Pavel Machek)
Date: Sun, 14 Apr 2013 20:07:29 +0200
Subject: [PATCHv3 1/3] ARM: socfpga: Enable soft reset
In-Reply-To: <1365695726-26849-1-git-send-email-dinguyen@altera.com>
References: <1365695726-26849-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130414180729.GA11770@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2013-04-11 10:55:24, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Enable a cold or warm reset to the HW from userspace.
> 
> Also fix a few sparse errors:
> 
> warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
> warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Reviewed-by: Pavel Machek <pavel@denx.de>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
