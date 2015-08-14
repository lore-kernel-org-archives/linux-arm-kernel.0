From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 14 Aug 2015 21:09:07 +0200
Subject: [PATCH] arm: mainstone_defconfig: disable IDE subsystem
In-Reply-To: <1439571876-13758-14-git-send-email-b.zolnierkie@samsung.com>
 (Bartlomiej Zolnierkiewicz's message of "Fri, 14 Aug 2015 19:04:29
 +0200")
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
 <1439571876-13758-14-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <87wpwxadrg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> This patch disables deprecated IDE subsystem in mainstone_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
