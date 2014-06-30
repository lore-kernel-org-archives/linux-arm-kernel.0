From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 15:20:39 +0200
Subject: [PATCH v7 0/4] arm: Fix DEBUG_LL for multi-platform kernels
 (without PL01X)
In-Reply-To: <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
References: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
 <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <4167835.TLMiA9Dyqd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 June 2014 12:30:51 Daniel Thompson wrote:
> This patchset removes some single-platform compatibility tricks related
> to DEBUG_LL and, as a result, allows multi_v7_defconfig derived builds
> to enable DEBUG_LL. Currently the user selected kbuild setting is
> ignored and the PL01X's DEBUG_LL stub is silently selected instead. This
> is a pain if your hardware doesn't have this cell, not least because it
> takes a little time to figure out that kbuild built the wrong code.

Looks fine to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>
