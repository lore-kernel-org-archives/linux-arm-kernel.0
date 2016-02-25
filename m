From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 14:24:48 +0100
Subject: [PATCH 00/61] gpio: Add and use devm_gpiochip_add_data()
In-Reply-To: <56CC7791.2000607@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
 <CACRpkdbt+RiWMA74e40MNZVnDM0t0futtFnbyu9sRhv7p93-Tg@mail.gmail.com>
 <56CC1FD4.1080905@nvidia.com> <56CC7791.2000607@nvidia.com>
Message-ID: <CACRpkdYsG8X5XiV2+Ss2GLJkFnLFzLi0uy0yy8R5sdi0b_Y+qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 4:15 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> I have made the repo in git hub as
>     https://github.com/ldewangan/linux-upstream.git

Awesome.

> branch name is devm_gpiochip.
>     https://github.com/ldewangan/linux-upstream/tree/devm_gpiochip

I've pulled this branch into my tree on a separate branch for
testing. I pushed the tree to kernel.org so that the zeroday
autobuilders can have a go at it.

If everything goes well I plan to merge this for v4.6, then we
can merge the changes in pin control and other subsystems
for v4.7.

Yours,
Linus Walleij
