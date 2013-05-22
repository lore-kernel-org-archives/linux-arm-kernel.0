From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 16:41:33 +0200
Subject: [PATCH] ARM: ux500: Apply other compatible name to the u8540 DTS
 file
In-Reply-To: <1369233402-19225-1-git-send-email-lee.jones@linaro.org>
References: <1369233402-19225-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201305221641.33602.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 May 2013, Lee Jones wrote:
> The common name for the 8540 is the u8540, but the fully qualified
> name, or proper name is ccu8540. Ensure both are available to drivers
> and platform code that wish to use them.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I'm confused by this. I thought that u8540 is the chipset while ccu8540 is
the board. Is that wrong?

	Arnd
