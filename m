From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jan 2017 14:06:23 +0200
Subject: [PATCH v2 00/13] Move pad retention control to Exynos pin
 controller driver
In-Reply-To: <CACRpkdbXcY5PtLUfJ5idq0XnHUZOdUk2GT5PVG9pkNYvQJ4vbQ@mail.gmail.com>
References: <CGME20170117124453eucas1p1b812596939db4c4f3298b941555eb05a@eucas1p1.samsung.com>
 <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdbXcY5PtLUfJ5idq0XnHUZOdUk2GT5PVG9pkNYvQJ4vbQ@mail.gmail.com>
Message-ID: <CAJKOXPf8a8MF9=4NKPDa1O9y1gabkG4D_khPV=9+CAWBeaqOTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 12:39 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Jan 17, 2017 at 1:44 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> This patchset is a follow-up of my work on adding runtime PM support
>> to Exynos pin controller driver:
>> http://www.spinics.net/lists/arm-kernel/msg550161.html
>
> Nice, once you are done fixing the remaining nits, add Tomasz ACKs
> and resend as v3 and I will apply it.

Wait, for the pinctrl patches (and also the commits moving the bits
arch/arm -> pintrl) you need the soc changes (mostly: the header).
I'll prepare a tag with them but I am still giving some time for
review.

Best regards,
Krzysztof
