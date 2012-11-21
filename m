From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Nov 2012 23:25:28 -0800
Subject: [PATCH 1/2] ARM: EXYNOS: Add aliases for i2c controller for
 exynos4
In-Reply-To: <1353450428-2615-1-git-send-email-dianders@chromium.org>
References: <1353450428-2615-1-git-send-email-dianders@chromium.org>
Message-ID: <20121121072528.GJ7615@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 02:27:03PM -0800, Doug Anderson wrote:
> This is similar to a recent commit for exynos5250 titled:
>   ARM: EXYNOS: Add aliases for i2c controller
> 
> Adding aliases will be useful to prevent warnings in a future
> change.  See:
>   i2c: s3c2410: Get the i2c bus number from alias id
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>

This can go in independently of the pending comment on the i2c driver change
(that it should be done in the core, which makes sense).


-Olof
