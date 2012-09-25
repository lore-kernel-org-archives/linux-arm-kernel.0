From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Sep 2012 17:10:16 +0000
Subject: [PATCH] ARM: ux500: Fix initialisation order for UIBs
In-Reply-To: <1348585812-32073-1-git-send-email-lee.jones@linaro.org>
References: <1348585812-32073-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201209251710.17014.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 September 2012, Lee Jones wrote:
> 
> An earlier change prevented User Interface Boards (UIBs) from being
> initialised on boards which did not support them. This change had
> the undesired effect of reordering the UIB initialisation calls with
> I2C registration. Here we ensure UIBs are only setup after all
> required infrastructure is already in place.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
