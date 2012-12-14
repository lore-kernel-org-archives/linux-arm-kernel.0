From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 14 Dec 2012 21:26:17 +0530
Subject: [PATCH 1/3] pinctrl: exynos: add exynos5250 SoC specific data
In-Reply-To: <CACRpkdaQ10CgoFXtk4EyqL4LWVpsdEAdrmy5R-_Rqm5fJdqS4A@mail.gmail.com>
References: <1355399644-29417-1-git-send-email-thomas.abraham@linaro.org>
 <1355399644-29417-2-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdaQ10CgoFXtk4EyqL4LWVpsdEAdrmy5R-_Rqm5fJdqS4A@mail.gmail.com>
Message-ID: <CAJuYYwTZkzCXjowhKaJ253Oji07eDdEjMvNssyL1ThWtETswSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 14 December 2012 21:21, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Dec 13, 2012 at 12:54 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>
>> Add Samsung Exynos5250 SoC specific data to enable pinctrl support for
>> all platforms based on Exynos5250.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> For this series, I guess you'll fix it through the Samsung tree?

Thanks for your ack. Since there are patches to be prepared for
migrating the rest of Exynos5250 related code to the pinctrl
framework, it would be easier if this series goes through the Samsung
tree.

Thanks,
Thomas.

>
> Yours,
> Linus Walleij
