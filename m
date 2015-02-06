From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 6 Feb 2015 14:49:53 +0100
Subject: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
In-Reply-To: <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150206134953.GA25683@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-01-30 15:47:58, Krzysztof Kozlowski wrote:
> Use power_supply_put() to decrement the power supply's device reference
> counter.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>

11,13,20 nothing obviously wrong. But I'm not sure if I studied them
closely enough to warrant an ACK.

It would be good to get this into kernel -- I seen no bad comments,
and it is not going to improve without merge into mainline.

									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
