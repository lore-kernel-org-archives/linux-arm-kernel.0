From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 17 Jan 2016 14:43:17 -0800
Subject: [PATCH 2/2] ARM: DTS: kirkwood-openrd: fix SD slot default
 configuration
In-Reply-To: <1452629253-21748-2-git-send-email-aaro.koskinen@iki.fi>
References: <1452629253-21748-1-git-send-email-aaro.koskinen@iki.fi>
 <1452629253-21748-2-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20160117224316.GA26018@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [2016-01-12 22:07]:
> The SD card slot was enabled by default with legacy booting.
> It does not work anymore with DT boot. Fix by providing GPIO configuration
> that matches the old default.

Tested-by: Rick Thomas <rbthomas@pobox.com>
Reviewed-by: Martin Michlmayr <tbm@cyrius.com>

-- 
Martin Michlmayr
http://www.cyrius.com/
