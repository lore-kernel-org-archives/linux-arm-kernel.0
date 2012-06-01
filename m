From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Jun 2012 09:40:14 +0800
Subject: [PATCH 0/3] pinctrl: add support for samsung pinctrl driver
In-Reply-To: <1337816857-14694-1-git-send-email-thomas.abraham@linaro.org>
References: <1337816857-14694-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdZ++GiqE55ofuwOssY4RLE5NctiY1rik1PDtm5r+CL4dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 7:47 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> Note that, the Samsung pinctrl driver is usable only on device tree enabled
> Samsung platforms. Legacy platforms would still continue to use the older
> gpiolib driver and hence updates to device drivers to use the pinctrl api
> should ensure that support for legacy platforms is maintained.

Is the plan to move also the older platforms over to the DT-based model?
It'd be really nice to be able to just delete the old drivers at some point...

Yours,
Linus Walleij
