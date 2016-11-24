From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Nov 2016 15:05:43 +0100
Subject: [PATCH 2/3] pinctrl: New driver for TI DA8XX/OMAP-L138/AM18XX
 pinconf
In-Reply-To: <1479871767-20160-3-git-send-email-david@lechnology.com>
References: <1479871767-20160-1-git-send-email-david@lechnology.com>
 <1479871767-20160-3-git-send-email-david@lechnology.com>
Message-ID: <CACRpkdYzJFdbEPON_TGDpzhNmA=e5O4XkhfYiWhgYj4p94=nHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 4:29 AM, David Lechner <david@lechnology.com> wrote:

> This adds a new driver for pinconf on TI DA8XX/OMAP-L138/AM18XX. These
> SoCs have a separate controller for controlling pullup/pulldown groups.
>
> Signed-off-by: David Lechner <david@lechnology.com>

Nice and clean driver, resend with the minor fixes pointed out
by Sekhar and I'll merge it.

Yours,
Linus Walleij
