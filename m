From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 21:13:14 +0000
Subject: [PATCH] clps711x: fix compilation breakage
In-Reply-To: <1325673453-22278-1-git-send-email-linus.walleij@linaro.org>
References: <1325673453-22278-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120104211314.GD11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 11:37:33AM +0100, Linus Walleij wrote:
> The restart patches defined a new restart function in common.c
> but it needs to be declared in common.h to compile properly.

Hmm, this ought to be merged into the commit which created the breakage -
are you ok if I just fix that commit?
