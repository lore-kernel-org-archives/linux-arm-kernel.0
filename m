From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 9 Dec 2010 16:30:28 +0530
Subject: [PATCH v7 11/12] davinci: add tnetv107x evm backlight device
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247CD83E1@dbde02.ent.ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
	<1291733522-3626-12-git-send-email-cyril@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247CD83E1@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247CD84F4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 14:25:49, Nori, Sekhar wrote:

> This call should simply return if machine is not tnetv107x EVM.
>
> I didn't follow the entire series but wondering why
> platform device registration should be a late init call.
> Typically the driver probe can be made a late init call
> in case of init sequence dependencies.

I meant driver init, not probe.

Thanks,
Sekhar
