From: nm@ti.com (Nishanth Menon)
Date: Fri, 21 Mar 2014 04:30:04 -0500
Subject: [PATCH V2] net: micrel : ks8851-ml: add vdd-supply support
In-Reply-To: <1395394080-28964-1-git-send-email-nm@ti.com>
References: <20140321085158.GB30910@pengutronix.de>
 <1395394080-28964-1-git-send-email-nm@ti.com>
Message-ID: <532C069C.7060208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 04:28 AM, Nishanth Menon wrote:

> +	ks->vdd_reg = regulator_get_optional(&spi->dev, "vdd");
ok, that is unbelievable.. no git commit --amend :(.. Apologies on the
spam.. will resent.


-- 
Regards,
Nishanth Menon
