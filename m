From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 May 2017 09:41:02 +0200
Subject: [PATCH 0/2] ARCH_VULCAN removal
In-Reply-To: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
References: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170522074102.tjhkx62fmjlb3lzf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 07:36:03AM +0000, Jayachandran C wrote:
> Another couple of patches to remove more of ARCH_VULCAN platform.
> 
> There is still a reference in drivers/gpio/Kconfig for ARCH_VULCAN.
> I am sending a patch to remove that, and after that we can completely
> remove ARCH_VULCAN.

What happens if ARCH_VULCAN and drivers/gpio/Kconfig still references
it? I expected it's just assumed to be 'n' then?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
