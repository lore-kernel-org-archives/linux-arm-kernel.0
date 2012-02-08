From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 8 Feb 2012 16:45:28 +0100
Subject: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft reset
 is performed
In-Reply-To: <20120208152621.GH15647@game.jcrosoft.org>
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
 <20120208152621.GH15647@game.jcrosoft.org>
Message-ID: <20120208154528.GC4919@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean-Christophe,

A customer using an Atheros AR6103 SDIO WLAN adapter faces this issue.

Sometimes we perform a software reset and he noticed that after he didn't get
sdio irq. The interrupt mask register is also resetted when performing
software reset.

Regards

Ludovic

On Wed, Feb 08, 2012 at 04:26:21PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:22 Wed 08 Feb     , ludovic.desroches at atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> why do you need this?
> 
> Best Regards,
> J.
> 
