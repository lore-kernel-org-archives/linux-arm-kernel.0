From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 12:43:24 +0200
Subject: [PATCH 0/7] ARM: ux500: Change naming convention for pinctrl
In-Reply-To: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYWVSriZZ5grQJ-9XM6JF2NjpeXiKrE1uCYU0KpVT80sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 4:22 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Our naming convention started off sensibly, but with the addition of
> more supported platforms it's slipped a little. Most compatible strings
> standardise themselves with "<vendor>,<device_name>-<device_type>",
> which we had initially with "stericsson,nmk-pinctrl", but with more
> devices to support we now have a tail, so we are using
> "<vendor>,<driver_name>-<device_type>-<device_name>", which is
> unsuitable.
>
> This patch-set ensures the standard convention is used again.

I buy this. I have applied patches 1, 4 and 6 to the ux500-devicetree
branch. I will apply the remaining patches to the Nomadik branch
(which is in another tree).

There might be some trivial conflict in drivers/pinctrl/pinctrl-nomadik.c
as a result of this being split in two trees but it'll be manageable
I think (will be resolved in ARM SoC).

Yours,
Linus Walleij
