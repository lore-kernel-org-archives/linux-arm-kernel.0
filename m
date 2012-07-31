From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Jul 2012 20:58:24 +0000
Subject: [PATCH 3/6] ARM: ux500: Remove unused snowball_of_platform_devs
 struct
In-Reply-To: <1343741493-17671-7-git-send-email-lee.jones@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-7-git-send-email-lee.jones@linaro.org>
Message-ID: <201207312058.24640.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 July 2012, Lee Jones wrote:
> This was left over during a recent clean-up which removed Device Tree
> helper structs. There is no longer a requirement for it, so we can just
> remove it.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
