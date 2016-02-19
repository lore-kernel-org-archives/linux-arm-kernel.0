From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 10:11:29 +0100
Subject: [PATCH v7 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <1455714909-3027-2-git-send-email-qnguyen@apm.com>
References: <1455714909-3027-1-git-send-email-qnguyen@apm.com>
 <1455714909-3027-2-git-send-email-qnguyen@apm.com>
Message-ID: <CACRpkdaH7CLZDK9HP1nCYioPVbypQsZ76ZJcPMPLjVzV-DWqDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 2:15 PM, Quan Nguyen <qnguyen@apm.com> wrote:

> Enable X-Gene standby GPIO controller as interrupt controller to provide
> its own resources. This avoids ambiguity where GIC interrupt resource is
> use as X-Gene standby GPIO interrupt resource in user driver.
>
> Signed-off-by: Y Vo <yvo@apm.com>
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Sweet! Patch applied.

Yours,
Linus Walleij
