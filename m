From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:16:59 +0200
Subject: [PATCH 07/16] ARM: ux500: Enable the SMSC9115 on Snowball via
 Device Tree
In-Reply-To: <1334659448-11521-8-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYrheyqnMgj4DhmX+-wipjxJS8H_KgdVFW6-zZcPLs_Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:43 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Enable the Ethernet port by providing correct information via DT.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I guess patches 5-7 are dependent on the GPIO IRQ domain being
fixed first in order to be applied or they won't work?

Yours,
Linus Walleij
