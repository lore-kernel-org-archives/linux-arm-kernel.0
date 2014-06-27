From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jun 2014 09:55:41 +0200
Subject: [PATCH] ARM: bcm: Fix bcm and multi_v7 defconfigs
In-Reply-To: <1403850439-8771-1-git-send-email-olof@lixom.net>
References: <1403850439-8771-1-git-send-email-olof@lixom.net>
Message-ID: <5792451.i1WdiOPTXg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 June 2014 23:27:19 Olof Johansson wrote:
> BCM (Kona/capri platform) has regressed in two ways on this release. First,
> bcm_defconfig no longer selected the appropriate MMC driver options due to
> changes in dependencies. Secondly, the new MFD and regulator drivers were not
> enabled on multi_v7_defconfig, so that caused the system to fail probing MMC
> there.
> 
> Fix by enabling the new options as needed.
> 
> Cc: Matt Porter <matt.porter@linaro.org>
> Cc: Christian Daudt <bcm@fixthebug.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
