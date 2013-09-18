From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Sep 2013 08:17:03 -0700
Subject: [PATCH] ARM: u300: hide submenus
In-Reply-To: <1379509732-25228-1-git-send-email-linus.walleij@linaro.org>
References: <1379509732-25228-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130918151703.GA23543@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 03:08:52PM +0200, Linus Walleij wrote:
> Right now the U300 submenus are showcased for everyone even if
> we're not on v5 multiplatforms. Hide this in the multiplatform
> configuration properly.
> 
> Cc: arm at kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I don't know if you feel this is a fix or not,
> feel free to apply it on your fixes if you like, else I'll carry
> it for a U300 pull request later.

We're early enough in the -rcs that this is OK, I'd say. Applied.


-Olof
