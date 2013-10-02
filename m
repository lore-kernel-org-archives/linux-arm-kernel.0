From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Oct 2013 21:32:19 +0100
Subject: [PATCH] ARM: h3600: update defconfig
In-Reply-To: <1380532794-17277-1-git-send-email-linus.walleij@linaro.org>
References: <1380532794-17277-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131002203219.GV12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:19:54AM +0200, Linus Walleij wrote:
> This updates the h3600 defconfig against the latest kernel with
> some small options coming and going due to Kconfig structure,
> then modernize it to:
> 
> - Use EABI to compile the kernel

EABI on ARMv4 *non-T* and without --fix-v4bx (a) added to the linker
arguments, and (b) V4BX relocations added to the kernel module loader?
Are you sure this is all that's required?
