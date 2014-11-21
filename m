From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 16:03:34 +0100
Subject: [PATCH 2/2] i2c: at91: enable probe deferring on dma channel
 request
In-Reply-To: <1416577472-24542-2-git-send-email-ludovic.desroches@atmel.com>
References: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
 <1416577472-24542-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <2530739.DkVu7IemRV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 14:44:32 Ludovic Desroches wrote:
> If dma controller is not probed, defer i2c probe.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---

Reviewed-by: Arnd Bergmann <arnd@arndb.de>


> 
> Arnd,
> 
> It's a combination of the first patch I sent and yours. As you said that my
> patch "looks wrong but actually it's ok" I didn't dare to add your
> signed-off-by.

I think a good way to deal with this is to explain in the patch description
who wrote what part.

	Arnd
