From: davem@davemloft.net (David Miller)
Date: Tue, 18 Feb 2014 18:09:18 -0500 (EST)
Subject: [PATCH v2] net: ethernet: update dependency and help text of
 mvneta
In-Reply-To: <1392729491-24913-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392729491-24913-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140218.180918.2278994810974129533.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 18 Feb 2014 14:18:11 +0100

> With the introduction of the support for Armada 375 and Armada 38x,
> the hidden Kconfig option MACH_ARMADA_370_XP is being renamed to
> MACH_MVEBU_V7. Therefore, the dependency that was used for the mvneta
> driver can no longer work. This commit replaces this dependency by a
> dependency on PLAT_ORION, which is used similarly for the mv643xx_eth
> driver.
> 
> In addition to this, it takes this opportunity to adjust the
> description and help text to indicate that the driver can is also used
> for Armada 38x. Note that Armada 375 cannot use this driver as it has
> a completely different networking unit, which will require a separate
> driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied, thanks.
