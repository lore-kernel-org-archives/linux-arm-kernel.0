From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 8 Feb 2012 17:17:17 +0100
Subject: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft
 reset is performed
In-Reply-To: <20120208154528.GC4919@ldesroches-Latitude-E6320>
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
 <20120208152621.GH15647@game.jcrosoft.org>
 <20120208154528.GC4919@ldesroches-Latitude-E6320>
Message-ID: <20120208161717.GI15647@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:45 Wed 08 Feb     , Ludovic Desroches wrote:
> Hello Jean-Christophe,
> 
> A customer using an Atheros AR6103 SDIO WLAN adapter faces this issue.
> 
> Sometimes we perform a software reset and he noticed that after he didn't get
> sdio irq. The interrupt mask register is also resetted when performing
> software reset.
so put this in the commit

Best Regards,
J.
