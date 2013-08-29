From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 11:00:40 -0700
Subject: [PATCH] gpio: (gpio-pca953x) move header to linux/platform_data/
In-Reply-To: <1859873512.636800.1377798778897.JavaMail.root@mail>
References: <ADE657CA350FB648AAC2C43247A983F0021DAC7DA184@AUSP01VMBX24.collaborationhost.net>
 <1859873512.636800.1377798778897.JavaMail.root@mail>
Message-ID: <20130829180040.GI18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 01:52:58PM -0400, Vivien Didelot wrote:
> As this patch mainly touches arch/arm/*, Olof/Kevin, would you mind
> applying it?
> 
> The first message in thread is here: https://lkml.org/lkml/2013/7/31/552
> Here are the previous ACKs:
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Looks like i2c or gpio maintainers should be taking it, but since Linus acked
it instead of applied it, I guess we can take it. :)

I'll apply it to next/cleanup for 3.12 if you resend me the patch with the
acks. Thanks!


-Olof
