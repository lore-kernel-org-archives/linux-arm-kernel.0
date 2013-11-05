From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 5 Nov 2013 14:12:32 +0100
Subject: [PATCH 3/4] wl1251: spi: add vio regulator support
In-Reply-To: <1382890469-25286-4-git-send-email-sre@debian.org>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-4-git-send-email-sre@debian.org>
Message-ID: <20131105131232.GD30670@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2013-10-27 17:14:28, Sebastian Reichel wrote:
> This patch adds support for requesting the regulator powering
> the vio pin.
> 
> The patch also adds the regulator for the all boards using the
> wl1251 in spi mode (only the Nokia N900).
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
