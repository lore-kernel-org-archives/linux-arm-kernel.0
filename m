From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Aug 2016 10:56:22 +0200
Subject: [PATCH 0/2] Fix Qualcomm 8064/8660 interrupt flags
In-Reply-To: <1470386318-17694-1-git-send-email-linus.walleij@linaro.org>
References: <1470386318-17694-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZR-R7cZkfpMJLOt8ND1bQmdxCuVF1BWEgeagWwfXAEDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2016 at 10:38 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This came out after some frustration with trying to flag a PM8058
> interrupt line on the APQ8060 (MSM8660) to trigger on falling
> edges. It was conflicting badly with predefined contradictory
> flags in the device tree for the entire GPIO block. The same
> seems to hold for the MPP GPIO IRQs.

Andy are you funneling these two patches for fixes?

Yours,
Linus Walleij
