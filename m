From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 09:10:08 +0200
Subject: [PATCH 4/9] ARM: ux500: Ensure vendor specific properties have
 the vendor's identifier
In-Reply-To: <1341493572-29735-5-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaM1J_iotK_mwXqAznQgRGMF=feZM7tK_rgcEbOrQkC5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Any non-standard property should contain the vendor's identifier which
> should be perpended onto the property name followed by a comma. This
> aids in name-space collision prevention.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
