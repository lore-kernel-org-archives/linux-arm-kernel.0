From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Nov 2011 20:10:23 +0100
Subject: [PATCH 1/7] ARM: restart: add restart hook to machine_desc record
In-Reply-To: <E1RN6ZV-0001Mv-LX@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ZV-0001Mv-LX@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdacpA59NO_7ra4Yhnc7FGzLcCjxMDAMTDcSZ9x+ikmqrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 6, 2011 at 6:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Add a restart hook to the machine_desc record so we don't have to
> populate all platforms with init_early methods to initialize the
> arm_pm_restart function pointer.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Obviously the right thing to do.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
