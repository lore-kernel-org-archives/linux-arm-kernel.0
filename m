From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:16:39 +0800
Subject: [PATCH 19/22] net/smsc911x: Repair broken failure paths
In-Reply-To: <1338353260-10097-20-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-20-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY=2j4gRGO4P4RfQDKo+sgV4akAQ6dpP4RbL+XywNCC5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Current failure paths attempt to free resources which we failed to request
> and disable resources which we failed to enable ones. This leads to kernel
> oops/panic. This patch does some simple re-ordering to prevent this from
> happening.
>
> Cc: netdev at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
