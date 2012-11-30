From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Nov 2012 11:17:48 +0000
Subject: [GIT PULL] GPIO patch stack for v3.8
In-Reply-To: <CACRpkdYDbfJO+RxbRpBmMi=mCj2L8a1rNgJgFW9EsxTPw2ivsA@mail.gmail.com>
References: <CACRpkdYDbfJO+RxbRpBmMi=mCj2L8a1rNgJgFW9EsxTPw2ivsA@mail.gmail.com>
Message-ID: <20121130111748.B872E3E14C4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2012 10:30:27 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi Grant,
> 
> to avoid any mess during the v3.8 merge window, could you please pull
> this patch stack to your GPIO branch for v3.8?
> 
> All these patches have been resting in linux-next and are reviewed and
> ACKed by maintainers. A more verbose description is in the signed
> tag.
> 
> Some confusion stems from the fact that I applied my own patches
> without replying to myself that I applied them ... split personality/role
> problem. If you pull this in, things should be more clear on what's
> queued and not - everything is in your tree.
> 
> Note that ARM SoC is already using parts of this tree as baseline
> for stuff in their tree so rebasing this patch trail is *not*
> recommended.

Don't worry, I won't rebase anything that I grab out of your tree.

> Please pull it in!
> 
> Apart from this there are a few gpiolib patches in the pinctrl tree as
> well. Those are about adding the GPIOchip local GPIO numberspace
> to pinctrl local numberspace ranges as we discussed with Dong
> Aisheng in Hong Kong, I'd be happy to brief you on the implementation
> if need be. It's also detailed here:
> https://blueprints.launchpad.net/linux-linaro/+spec/pinctrl-gpiorange-makeover

Those are fine.

g.
