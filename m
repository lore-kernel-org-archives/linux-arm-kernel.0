From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 00:03:30 +0200
Subject: [PATCH v3 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <537921DE.3030107@gmail.com>
References: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkdYJU3HN2u=eFPUyM4eMmuT1Xw19zxjpb5nj9nXnar3_-A@mail.gmail.com>
 <537921DE.3030107@gmail.com>
Message-ID: <CACRpkdYEVHRw2fukQD6fn0qYauquEWrzhVTBZvGLFNgzPmSX9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 18, 2014 at 11:10 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> I have reworked berlin's pinctrl drivers so they use a mmio regmap
> instead of ioremapped addresses. Instead of "independent" pinctrl
> nodes, there will be common chip-ctrl/system-ctrl nodes that provide
> both clocks and pinctrl (and reset, padmux, ...).
(...)
> I need Alexandre and Antoine to add the necessary changes for BG2Q
> clocks and pinctrl respectively first, but do you prefer proper
> follow-up patches or can you squash them into the ones you've just
> taken?

I just took the Berlin patches out of my queue. Apparently this
driver needs some more maturing so let's not rush it at this point.
Let us merge this after v3.16-rc1 instead as one of the first things.

Yours,
Linus Walleij
