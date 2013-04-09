From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 20:55:55 +0200
Subject: [PATCH 7/8] dmaengine: ste_dma40: Use the BIT macro to replace
 ugly '(1 << x)'s
In-Reply-To: <1365532783-27425-7-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-7-git-send-email-lee.jones@linaro.org>
Message-ID: <201304092055.55661.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> The aim is to make the code that little more readable.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I don't find the new version any more or less readable than the old one,
but I have no objections if other people think it's a good idea.

Acked-by: Arnd Bergmann <arnd@arndb.de>
