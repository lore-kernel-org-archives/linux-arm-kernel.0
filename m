From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 20:51:12 +0200
Subject: [PATCH 8/8] ARM: ux500: Amalgamate DMA source and destination
 channel numbers
In-Reply-To: <1365532783-27425-8-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-8-git-send-email-lee.jones@linaro.org>
Message-ID: <201304092051.13138.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> Devices which utilise DMA tend to use the same channel numbers for
> transmitting and receiving. For this reason and the fact that it'll
> decrease the burden of platform data passed to each device, we're
> amalgamating source and destination device types.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Very nice cleanup!

Acked-by: Arnd Bergmann <arnd@arndb.de>
