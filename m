From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 15:15:29 +0200
Subject: Tag on pinctrl
Message-ID: <CACRpkdYqZrNFxj4kyMqYZk5PAcjF6-TroJ+Xq+3EVBLvo5Zg-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A while back I created a tag:

pinctrl-mergebase-20120418

On the pinctrl tree. It contains stuff up until that date that
has since been sitting in linux-next for a while.

I do not expect to rebase these patches further. They
are based on v3.4-rc3. So I will base any further pinctrl
work on this.

I think Stephen needed to pull this into the ARM SoC tree?

Anyone else? Viresh's driver would survive without the
latest fixes and doings in pinctrl IIRC.

Yours,
Linus Walleij
