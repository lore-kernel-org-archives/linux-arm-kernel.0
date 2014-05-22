From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 00:11:19 +0200
Subject: [PATCH v4 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <1400520995-27365-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1400520995-27365-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkda6-W6rNXtAbcTs6dgp4WLExXra6P_dqQbuYsRWi7MaOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 7:36 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> but can you please drop the Berlin pinctrl patches
> and reconsider taking the reworked driver instead?

Sure I applied patches 1 thru 4 to the pin control tree.
The rest you need to carry in some ARM SoC tree or
similar.

I don't mind the driver being half-merged like this, because
it means we can work on consolidating the utils code
in the next cycle.

Yours,
Linus Walleij
