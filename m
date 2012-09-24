From: olof@lixom.net (Olof Johansson)
Date: Mon, 24 Sep 2012 10:09:36 -0700
Subject: [PATCH] irqchip: fill in empty Kconfig
In-Reply-To: <1348506174-28641-1-git-send-email-swarren@wwwdotorg.org>
References: <1348506174-28641-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOesGMjv6nU3vH0KX56ib2ptLsDOR9KrDvGngHNLAmdBLyML+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 24, 2012 at 10:02 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Commit 89214f0 "ARM: bcm2835: add interrupt controller driver" added an
> empty drivers/irqchip/Kconfig. Empty files apparently don't work well
> with git (sometimes, with some versions?) so add some dummy content to
> resolve this issue.

Applied to arm-soc. Thanks.


-Olof
