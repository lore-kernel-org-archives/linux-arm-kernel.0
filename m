From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Dec 2012 01:34:29 +0100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
In-Reply-To: <027101cddf2c$b4f2f9b0$1ed8ed10$@samsung.com>
References: <20121221132014.0bf8772fb3e48c51cec1548a@canb.auug.org.au>
 <027101cddf2c$b4f2f9b0$1ed8ed10$@samsung.com>
Message-ID: <CACRpkdb50D+PMNf9sPTGUs9fsE-QOP0aWB+_aQ6ZpqLuFkvjUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 4:38 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Stephen Rothwell wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the arm-soc tree got conflicts in
>> drivers/pinctrl/pinctrl-exynos5440.c and
>> drivers/pinctrl/pinctrl-samsung.c between commit e5b4c9d4ab55 ("pinctrl:
>> exynos5440: Fix compile error in pinctrl-exynos5440/samsung.c") from the
>> pinctrl tree and commit d5fd5da290ce ("pinctrl: exynos5440/samsung:
>> Staticize pcfgs") from the arm-soc tree.
>>
> Oops, the commit d5fd5da290ce already sent to Linus Torvalds via arm-soc
> tree today. In addition, I applied with Linus Walleij's ack ;-)
>
> Linus Walleij, please drop the patch in your tree. Sorry I didn't notify
> about that when I got the patch from Choi.

OK dropped it, sorry for the delay...

Yours,
Linus Walleij
