From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:19:56 +0200
Subject: [PATCH 12/16] mfd/db8500-prcmu: Register as a platform driver
 instead of only probing
In-Reply-To: <1334659448-11521-13-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaNjMJxYCF0SZt3TT=qUXsd0bK6EjWcSqBqsr9_ZHGpSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:44 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Pass the probe function as part of the platform_driver struct and
> register using the more common platform_driver_register call. In
> subsequent patches we'll also add DT support into the struct.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This goes through the MFD tree so send it to Samuel Ortiz + LKML.

If you get his ACK I can take it through ux500-core.

Yours,
Linus Walleij
