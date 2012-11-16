From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Nov 2012 08:18:01 +0000
Subject: [PATCH] ARM: add get_user() support for 8 byte types
In-Reply-To: <1353016879-15007-1-git-send-email-rob.clark@linaro.org>
References: <1353016879-15007-1-git-send-email-rob.clark@linaro.org>
Message-ID: <201211160818.01302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Rob Clark wrote:
> 
> From: Rob Clark <rob@ti.com>
> 
> A new atomic modeset/pageflip ioctl being developed in DRM requires
> get_user() to work for 64bit types (in addition to just put_user()).
> 
> v1: original
> v2: pass correct size to check_uaccess, and better handling of narrowing
>     double word read with __get_user_xb() (Russell King's suggestion)
> v3: explain in comment about why this works for narrowing fetch to 1,
>     2, or 4 byte type on ARM.
> 
> Signed-off-by: Rob Clark <rob@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
