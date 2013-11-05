From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 5 Nov 2013 13:13:53 +0100
Subject: [PATCH 1/4] wl1251: split wl251 platform data to a separate
 structure
In-Reply-To: <1382890469-25286-2-git-send-email-sre@debian.org>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-2-git-send-email-sre@debian.org>
Message-ID: <20131105121353.GB30670@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2013-10-27 17:14:26, Sebastian Reichel wrote:
> From: Luciano Coelho <coelho@ti.com>
> 
> Move the wl1251 part of the wl12xx platform data structure into a new
> structure specifically for wl1251.  Change the platform data built-in
> block and board files accordingly.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
