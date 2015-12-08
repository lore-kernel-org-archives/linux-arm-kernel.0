From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 11:02:26 +0100
Subject: [PATCH v7 2/6] mfd: syscon: add a DT property to set value width
In-Reply-To: <20151207194218.GB6030@localhost>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151207094020.GF3384@x1> <20151207194218.GB6030@localhost>
Message-ID: <4387768.MyTgBTEZTT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 14:42:18 Damien Riegel wrote:

> Good to see this patch applied. What's going on now with the other
> patches of this serie ? How should I handle them ?

I don't see any build-time dependencies between the patches, so
please submit them to the respective maintainers.

Patch 3 and 5 should go through the watchdog tree, and Shawn can take
the other ones and submit them through arm-soc.

	Arnd
