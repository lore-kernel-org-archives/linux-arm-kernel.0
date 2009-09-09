From: wim@iguana.be (Wim Van Sebroeck)
Date: Wed, 9 Sep 2009 17:01:59 +0200
Subject: [PATCH 0/3] [ARM] Watchdog support for Samsung 6410 SoC
In-Reply-To: <1252494216-6434-1-git-send-email-laforge@gnumonks.org>
References: <1252494216-6434-1-git-send-email-laforge@gnumonks.org>
Message-ID: <20090909150159.GA25057@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harald,

> From: Harald Welte <laforge@gnumonks.org>
> 
> This patch series extends the existing watchdog timer support on
> Samsung 24xx SoC's to Samsung 6410 SoC. This patch series includes
> the following patches.
> 
> [PATCH 1/3] [ARM] s3c: move watchdog dev from plat-24xx into plat-s3c
> [PATCH 2/3] watchdog: Samsung SoC Watchdog is not s3c24xx specific
> [PATCH 3/3] [ARM] Enable watchdog platform device on SMDK6410 

The patches are OK for me.

Hi Russell, Ben,

Are they also ok for you? How will we get this mainline? Patch 2 is something that can go via the watchdog tree, but the other patches could probably better go via the arm tree.

Kind regards,
Wim.
