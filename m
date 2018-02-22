From: eric@anholt.net (Eric Anholt)
Date: Thu, 22 Feb 2018 12:06:50 -0800
Subject: [PATCH v5 5/5] ARM: dts: bcm2837-rpi-3-b: add GPIO expander
In-Reply-To: <CACRpkdaOv8yH2M8DVy-owY3zFGwAo52YCFksxEchjQyK3h47=A@mail.gmail.com>
References: <cover.1519128054.git.baruch@tkos.co.il>
 <a6d59692dc4847e0b1639a26542e28c95ad5240f.1519128054.git.baruch@tkos.co.il>
 <CACRpkdaOv8yH2M8DVy-owY3zFGwAo52YCFksxEchjQyK3h47=A@mail.gmail.com>
Message-ID: <87bmggaiw5.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Tue, Feb 20, 2018 at 1:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>
>> Add a description of the RPi3 GPIO expander that the VC4 firmware controls.
>>
>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v5:
>>   * Drop the 'firmware' property
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please funnel this patch through the ARM SoC tree.

Picked up the reviews and applied these last 2 to bcm2835-dt-next.  I
didn't see the gpio tree's for-next updated, so I didn't integration
test it personally, but hopefully our branches can come together in
-next soon.

(FWIW, I was looking at
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for
gpio)

Thanks for pushing this to completion, Baruch!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/f4ec0701/attachment.sig>
