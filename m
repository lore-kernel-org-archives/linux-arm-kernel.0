From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 May 2014 15:04:07 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <5678119.IM3FN0FlT6@wuerfel>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <201405091244.02066.arnd@arndb.de>
 <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
 <5678119.IM3FN0FlT6@wuerfel>
Message-ID: <CACRpkdYE0Fb+HezqgDbVcqQmWwn7QL2+RWSRyAigv2qcMp2qFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 10:31 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 22 May 2014 09:41:39 Linus Walleij wrote:

>> The question can be rephrased like this:
>> Should we create drivers/soc?
>
> I think we just did, not sure if the patches have made it into linux-next
> already, but there were a couple of other platforms already that want this
> directory.

Awesomeness. Can you give me the title of a patch or branch
from ARM SoC I should pull in to build on top of this? Then I can
split off all the SoC bus business and have the machine file real
small, nice and clean.

Yours,
Linus Walleij
