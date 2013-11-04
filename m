From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Nov 2013 11:42:23 +0000
Subject: [PATCH] ARM: footbridge: fix build warning
In-Reply-To: <1383552296-16275-1-git-send-email-linus.walleij@linaro.org>
References: <1383552296-16275-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131104114223.GP16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 09:04:56AM +0100, Linus Walleij wrote:
> The raw spinlock in the netwinder GPIO implementation was using
> non-raw accessors, fix this warning from the autobuilder:

I've already got this in my tree.  Thanks anyway.
