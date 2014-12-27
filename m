From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 27 Dec 2014 20:09:30 +0100
Subject: [PATCH 3/3] ARM: dts: OMAP34xx/36xx: Add temperature sensor
In-Reply-To: <1419597294-21487-4-git-send-email-sre@kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-4-git-send-email-sre@kernel.org>
Message-ID: <20141227190930.GA10007@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-12-26 13:34:54, Sebastian Reichel wrote:
> OMAP34xx and OMAP36xx processors contain a register in the
> syscon area, which can be used to determine the SoCs temperature.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>

Driver binds and does something, so binding works ok.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
