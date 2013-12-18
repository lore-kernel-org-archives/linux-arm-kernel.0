From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 11:06:31 +0000
Subject: [PATCH 1/3 v2] regulator: act8865: add PMIC act8865 driver
In-Reply-To: <B256D81BAE5131468A838E5D7A24364172F18381@penmbx01>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
 <1387258597-21866-2-git-send-email-wenyou.yang@atmel.com>
 <20131217130653.GA3185@sirena.org.uk>
 <B256D81BAE5131468A838E5D7A24364172F18381@penmbx01>
Message-ID: <20131218110631.GD28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:11:12AM +0000, Yang, Wenyou wrote:

> > This is the wrong type for a voltage table but it looks like it
> > shouldn't be a voltage table at all - this looks like it should be
> > mapped as linear ranges.

> Change it, using unsigned int.

> It is not linear, can't be mapped as linear range. so using voltage table.

No, linear ranges with a plural - look at regulator_map_voltage_linear_range.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/7cce3b37/attachment.sig>
