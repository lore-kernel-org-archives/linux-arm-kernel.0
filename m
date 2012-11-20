From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Nov 2012 10:28:47 -0700
Subject: [PATCH 4/7] gpiolib: return any error code from range creation
In-Reply-To: <1353420282-18066-1-git-send-email-linus.walleij@stericsson.com>
References: <1353420282-18066-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50ABBDCF.3080309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 07:04 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If we try to create a range for a certain GPIO chip and the
> target pin controller is not yet available it may return
> a probe deferral error code, so handle this all the way
> our by checking the error code.

I think patches 3 and 4 need to be squashed together to avoid any "git
bisect" issues?
