From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Aug 2016 14:20:51 +0530
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable modules for sound
 on LCDK
In-Reply-To: <20160810200853.24275-2-kbeldan@baylibre.com>
References: <20160810200853.24275-1-kbeldan@baylibre.com>
 <20160810200853.24275-2-kbeldan@baylibre.com>
Message-ID: <52f428a2-7818-5f3a-bb66-70e2eaa63e7a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 August 2016 01:38 AM, Karl Beldan wrote:
> This is the minimal set of additional modules required to support audio
> on the LCDK.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

This patch does not apply because Kevin already added some missing audio
modules through commit "ARM: davinci_all_defconfig: enable DA850 audio
as modules"

Can you please rebase on master branch of my tree[1] and resend?

Regards,
Sekhar

[1]
https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/
