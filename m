From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 15 Oct 2014 12:33:04 +0200
Subject: [PATCH 3/8] power: 88pm860x_charger: Use power_supply_*() API
 for accessing function attrs
In-Reply-To: <1413289246-31650-4-git-send-email-k.kozlowski@samsung.com>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
 <1413289246-31650-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141015103304.GC14266@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2014-10-14 14:20:41, Krzysztof Kozlowski wrote:
> Replace direct calls to power supply function attributes with wrappers.
> Wrappers provide safe access access in case of unregistering the power
> supply (.e.g by removing the driver). Replace:
>  - get_property -> power_supply_get_property
>  - set_property -> power_supply_set_property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
