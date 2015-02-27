From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Feb 2015 20:26:59 +0100
Subject: [PATCH v5 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
In-Reply-To: <1425025201-15926-21-git-send-email-k.kozlowski@samsung.com>
References: <1425025201-15926-1-git-send-email-k.kozlowski@samsung.com>
 <1425025201-15926-21-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150227192659.GA13676@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-02-27 09:20:01, Krzysztof Kozlowski wrote:
> Use power_supply_put() to decrement the power supply's device reference
> counter.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
