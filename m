From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Apr 2012 13:36:39 +0200
Subject: [PATCH 01/15] ARM: ux500: Enable the external bus with Device Tree
In-Reply-To: <1334867804-31942-2-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZw+UX=h04PSJOCzwaTFFYRv66t0wEF1BMcS1GGmut0Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> To allow for proper initialisation of the SMSC9115 Ethernet chip
> and other devices which may be connected to the 'external bus',
> Device Tree must first enable and traverse though it. This patch
> enables the 'external bus' which will facilitate further
> initialisation of its suborantate DT nodes.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks for fixing it up!
Applied.

Yours,
Linus Walleij
