From: kvalo@codeaurora.org (Kalle Valo)
Date: Tue, 21 Jul 2015 17:07:23 +0300
Subject: [PATCH] bcma: populate bus DT subnodes as platform_device-s
In-Reply-To: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
 (=?utf-8?Q?=22Rafa=C5=82=09Mi=C5=82ecki=22's?= message of "Sun, 28 Jun 2015
 17:17:13 +0200")
References: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
Message-ID: <871tg1ob8k.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafa? Mi?ecki <zajec5@gmail.com> writes:

> Our bus should allow defining children nodes as we may want to specify
> devices attached to the bus. This is required e.g. to specify NAND or
> ChipCommon cores and use bus's address and IRQ mappings.
>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Thanks, manually applied to wireless-drivers-next.git.

-- 
Kalle Valo
