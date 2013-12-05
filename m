From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Dec 2013 22:24:55 -0700
Subject: [PATCH 1/2] ARM: bcm2835: rebuild bcm2835_defconfig
In-Reply-To: <1386131576-21137-1-git-send-email-swarren@wwwdotorg.org>
References: <1386131576-21137-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52A00E27.5090907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 09:32 PM, Stephen Warren wrote:
> This is simply "make bcm2835_defconfig ; make savedefconfig". It
> separates out the irrelevant changes from the later patches for
> clarity.

I've squashed this series into bcm2835's for-3.14/defconfig branch.
