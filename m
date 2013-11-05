From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 5 Nov 2013 14:11:32 +0100
Subject: [PATCH 2/4] wl1251: move power GPIO handling into the driver
In-Reply-To: <1382890469-25286-3-git-send-email-sre@debian.org>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-3-git-send-email-sre@debian.org>
Message-ID: <20131105131132.GC30670@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2013-10-27 17:14:27, Sebastian Reichel wrote:
> Move the power GPIO handling from the board code into
> the driver. This is a dependency for device tree support.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
