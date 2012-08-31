From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 31 Aug 2012 16:42:28 +0200
Subject: [PATCH 8/8] ARM: dts: add twi nodes for atmel boards
In-Reply-To: <1346405096-18660-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346405096-18660-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120831144228.GC23867@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:24 Fri 31 Aug     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Use the atmel twi instead of gpio for i2c stuff.
NACK as you do not update al the platform at the same time and break the Calao

Best Regards,
J.
