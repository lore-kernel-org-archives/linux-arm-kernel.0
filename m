From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 9 May 2011 22:15:03 +0200
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20110509201503.GB21233@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2011 at 10:11:09PM +0200, Antonio Ospite wrote:
> Don't wrap regulator_get() inside an #ifdef CONFIG_REGULATOR anymore, as
> now (since be1a50d) it correctly degenerates and returns NULL when the
> regulator framework is disabled.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

But pleasse always include a plain text version of the commit
description for those who didn't memorise the entire git log.
