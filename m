From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 1 Jun 2012 10:06:27 +0800
Subject: [PATCH 0/3] pinctrl: add support for samsung pinctrl driver
In-Reply-To: <CACRpkdZ++GiqE55ofuwOssY4RLE5NctiY1rik1PDtm5r+CL4dw@mail.gmail.com>
References: <1337816857-14694-1-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdZ++GiqE55ofuwOssY4RLE5NctiY1rik1PDtm5r+CL4dw@mail.gmail.com>
Message-ID: <CAJuYYwQWDFx-13_Q5a0dFTjd=KbfkoFg5ciCcD4G4hybsBd6fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2012 09:40, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, May 24, 2012 at 7:47 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>
>> Note that, the Samsung pinctrl driver is usable only on device tree enabled
>> Samsung platforms. Legacy platforms would still continue to use the older
>> gpiolib driver and hence updates to device drivers to use the pinctrl api
>> should ensure that support for legacy platforms is maintained.
>
> Is the plan to move also the older platforms over to the DT-based model?
> It'd be really nice to be able to just delete the old drivers at some point...

As of now, there is no plan to move the older Samsung platforms to
DT-based model. Moving to DT-based model requires people with the
board support upstreamed for older Samsung SoC's to sign up for the dt
conversion process without which testing will not be possible. So for
now, we will have to maintain the old drivers also.

Thanks,
Thomas.

>
> Yours,
> Linus Walleij
